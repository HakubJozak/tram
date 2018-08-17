require "sdl2"
require "pry"

require_relative "path"
require_relative "vector2"







class TramGame

  def initialize
    @path = Path.new

    SDL2.init SDL2::INIT_VIDEO  |
              SDL2::INIT_AUDIO  |
              SDL2::INIT_EVENTS |
              SDL2::INIT_TIMER

    SDL2::Mouse::Cursor.hide

    window = SDL2::Window.create("testsprite",
                                 SDL2::Window::POS_CENTERED,
                                 SDL2::Window::POS_CENTERED,
                                 1024, 768, 0)

    @renderer = window.create_renderer(-1, 0)
  end

  def run
    loop do
      while event = SDL2::Event.poll
        case event
        when SDL2::Event::KeyDown
          on_key_down(event.scancode)
        when SDL2::Event::MouseButtonDown
          on_mouse_down(event)
        end
      end

      @renderer.draw_color = [0,0,0]
      @renderer.clear

      mouse = SDL2::Mouse.state
      draw_cross(mouse)
      @path.draw(self)

      @renderer.present
    end
  end

  def on_key_down(scancode)
    case scancode
    when SDL2::Key::Scan::ESCAPE then exit
    end
  end

  def on_mouse_down(event)
    if event.button == 1
      @path << Vector2.new(event.x, event.y)
    end
  end

  def draw_dot(a, color = [255, 255, 0])
    @renderer.draw_color = color
    @renderer.draw_point(a.x, a.y)
  end

  def draw_cross(a, color = [0,255,0], size = 5 )
    @renderer.draw_color = color
    @renderer.draw_line(a.x - size , a.y - size, a.x + size, a.y + size)
    @renderer.draw_line(a.x - size , a.y + size, a.x + size, a.y - size)    
  end

  def draw_square(a, color = [255,0,0], size = 5)
    @renderer.draw_color = color
    rect = SDL2::Rect.new(a.x - size, a.y - size, size, size)
    @renderer.fill_rect(rect)
  end

end



TramGame.new.run
