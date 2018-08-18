require "sdl2"
require "pry"

require_relative "vector2"
require_relative "mouse"
require_relative "pen"
require_relative "path"
require_relative "builder"
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
    @plan  = Plan.new
    @pen   = Pen.new(window)
  end

  def run
    loop do
      while event = SDL2::Event.poll
        case event
        when SDL2::Event::KeyDown
          on_key_down(event.scancode)
        when SDL2::Event::MouseButtonDown
          case event.button
          when 1
            if nn = @plan.nearest_vertex(@mouse)
              @selected = nn
            else
              created = Vertex.new(event)
              @plan.add created
              
              if @last
                @plan.add Segment.new(@last, created)
              end
              
              @last = created
            end
            break
          when 3
            if nn = @path.find_nearest(@mouse)
              @path.remove(nn)
            else
              @selected = nil
            end
            break
          end
        when SDL2::Event::MouseButtonUp
          @selected = nil
        end
      end

      # moving the selected point by mouse
      @selected.update(@mouse) if @selected

      @pen.clear!
      @plan.draw(@pen)
      @mouse.draw(@pen)

      # highlight the nearest
      # if nearest = @path.find_nearest(@mouse)
      #   @pen.draw_square(nearest, color = [255,0,0])
      # end

      @pen.show!
    end
  end

  def on_key_down(scancode)
    case scancode
    when SDL2::Key::Scan::ESCAPE
      exit
    when SDL2::Key::Scan::U
    end
  end

  def on_mouse_down(event)
    if event.button == 1
    end
  end


  # def message
  #   @font = SDL2::TTF.open("caviar_dreams_bold.ttf", 40)
  #   @texture = @renderer.create_texture_from(@font.render_solid("Hi", [255, 255, 255]))
  #   @renderer.copy(@texture, nil, SDL2::Rect.new(10, 20, 100, 300))
  # end

end



TramGame.new.run
