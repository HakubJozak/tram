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
    SDL2.init SDL2::INIT_VIDEO  |
              SDL2::INIT_AUDIO  |
              SDL2::INIT_EVENTS |
              SDL2::INIT_TIMER

    window = SDL2::Window.create("testsprite",
                                 SDL2::Window::POS_CENTERED,
                                 SDL2::Window::POS_CENTERED,
                                 1024, 768, 0)

    @renderer = window.create_renderer(-1, 0)
  end

  def lerp(a,b,t)
    a + (b-a) * t
  end

  def run
    a = Vector2.new(30,20)
    b = Vector2.new(643,600)
    t = 0.0

    loop do
      while event = SDL2::Event.poll
        case event
        when SDL2::Event::KeyDown
          on_key_down(event.scancode)
        end
      end

      draw_dot(lerp(a,b,t))
      t += 0.001 unless t > 1.0
      
      @renderer.present
    end
  end

  def on_key_down(scancode)
    case scancode
    when SDL2::Key::Scan::ESCAPE then exit
    end
  end

  private

  def draw_dot(a)
    @renderer.draw_color = [255, 255, 0]
    @renderer.draw_point(a.x, a.y)
  end

end



TramGame.new.run                         










