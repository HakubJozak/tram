require "sdl2"
require "pry"



class Vector2

  attr_reader :x, :y

  def initialize(a,b)
    @x = a
    @y = b
  end

  def +(b)
    Vector2.new(x + b.x, y + b.y)
  end

  def -(b)
    Vector2.new(x - b.x, y - b.y)
  end

  def *(alpha)
    Vector2.new(alpha * x, alpha * y)
  end

  # def +=(b)
  #   self[0] += b[0]
  #   self[1] += b[1]
  #   self
  # end

end





class TramGame

  def initialize
    @a = Vector2.new(30,20)
    @b = Vector2.new(643,600)

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

  def lerp(a,b,t)
    a + (b-a) * t
  end

  def qerp(a,b,c, &block)
    t = 0.0

    while t < 1.0
      q1 = a * ((1-t)**2)
      q2 = b * (2*(1-t) * t)
      q3 = c * (t**2)
      yield q1 + q2 + q3
      t += 0.001
    end
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
      x = Vector2.new(event.x, event.y)
      draw_cross(x)

      qerp(@a,x,@b) do |x|
	draw_dot(x)
      end
    end
  end

  private

  def draw_dot(a, color = [255, 255, 0])
    @renderer.draw_color = color
    @renderer.draw_point(a.x, a.y)
  end

  def draw_cross(a, color = [0,255,0] )
    size = 5
    @renderer.draw_color = color
    @renderer.draw_line(a.x - size , a.y - size, a.x + size, a.y + size)
    @renderer.draw_line(a.x - size , a.y + size, a.x + size, a.y - size)    
  end

end



TramGame.new.run
