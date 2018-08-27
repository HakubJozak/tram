#!/usr/bin/env ruby
require "sdl2"
require "pry"
require "yaml"

require_relative "vector2"
require_relative "mouse"
require_relative "pen"
require_relative "path"
require_relative "naming"

require_relative "tool/base"
require_relative "tool/creator"
require_relative "tool/mover"
require_relative "builder"
require_relative "game"
require_relative "ball"

require_relative "plan"
require_relative "segment"
require_relative "vertex"




class TramGame

  def initialize
    SDL2.init SDL2::INIT_VIDEO  |
              SDL2::INIT_AUDIO  |
              SDL2::INIT_EVENTS |
              SDL2::INIT_TIMER

    SDL2::TTF.init
    SDL2::Mouse::Cursor.hide

    window = SDL2::Window.create("testsprite",
                                 SDL2::Window::POS_CENTERED,
                                 SDL2::Window::POS_CENTERED,
                                 1024, 768, 0)

    @mouse = Mouse.new


    @plan    = if File.exist?('plan.yml')
                 Plan.new YAML.load_file('plan.yml')
               else
                 Plan.new
               end

    @state   = Builder.new(plan: @plan, mouse: @mouse)
    @pen     = Pen.new(window)
  end

  def run
    loop do
      while event = SDL2::Event.poll
        case event
        when SDL2::Event::KeyDown
          on_key_down(event)

        when SDL2::Event::MouseButtonDown
          @state.mouse_down(event)

        when SDL2::Event::MouseButtonUp
          @state.mouse_up(event)
        end
      end

      @state.update

      @pen.clear!
      @state.draw(@pen)

      @pen.show!
    end
  end


  def on_key_down(event)
    case event.scancode
    when SDL2::Key::Scan::ESCAPE
      exit
    when SDL2::Key::Scan::S
      if event.mod & 64
        require 'yaml'

        File.open('plan.yml','w') do |f|
	  f.write @plan.to_h.to_yaml
        end

        puts 'Saved.'
      end
    when SDL2::Key::Scan::B
      @state = Builder.new(plan: @plan, mouse: @mouse)

    when SDL2::Key::Scan::P
      unless @plan.empty?
        @state = Game.new(plan: @plan, mouse: @mouse)
      end
    else
      @state.key_down(event)
    end

  end


  # def message
  #   @font = SDL2::TTF.open("caviar_dreams_bold.ttf", 40)
  #   @texture = @renderer.create_texture_from(@font.render_solid("Hi", [255, 255, 255]))
  #   @renderer.copy(@texture, nil, SDL2::Rect.new(10, 20, 100, 300))
  # end

end



TramGame.new.run
