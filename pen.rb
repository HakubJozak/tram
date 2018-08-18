class Pen

  def initialize(window)
    @renderer = window.create_renderer(-1, 0)
  end

  def clear!
    @renderer.draw_color = [0,0,0]
    @renderer.clear
  end

  def show!
    @renderer.present    
  end

  def draw_dot(a, color = [255, 255, 0])
    @renderer.draw_color = color
    @renderer.draw_point(a.x, a.y)
  end

  def draw_cross(a, color = [0,255,0], size = 8)
    @renderer.draw_color = color
    @renderer.draw_line(a.x - size , a.y - size, a.x + size, a.y + size)
    @renderer.draw_line(a.x - size , a.y + size, a.x + size, a.y - size)    
  end

  def draw_square(a, color = [255,0,0], size = 8)
    @renderer.draw_color = color
    rect = SDL2::Rect.new(a.x - size, a.y - size, size, size)
    @renderer.fill_rect(rect)
  end

  def draw_rect(a, color = [255,0,0], size = 8)
    @renderer.draw_color = color
    rect = SDL2::Rect.new(a.x - size, a.y - size, size, size)
    @renderer.draw_rect(rect)
  end  

end
