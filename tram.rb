require "sdl2"
require "pry"

require_relative "mouse"
require_relative "pen"
require_relative "path"
require_relative "vector2"







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

    @path = Path.new
    @mouse = Mouse.new
    @pen = Pen.new(window)
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
            if nn = @path.find_nearest(@mouse)
              @selected = nn
            else
              @selected = nil
              @path << Vector2.new(event.x, event.y)
            end
            break
          when 3
            if nn = @path.find_nearest(@mouse)
              @path.remove(nn)
            end
            break
          end
        when SDL2::Event::MouseButtonUp
          @selected = nil
        end
      end

      @selected.update(@mouse) if @selected

      @pen.clear!

      @path.draw(@pen)
      @mouse.draw(@pen)

      # highlight the nearest
      if nearest = @path.find_nearest(@mouse)
        @pen.draw_square(nearest, color = [255,0,0])
      end

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
