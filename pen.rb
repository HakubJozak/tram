class Pen

  BLACK   = [ 0,0,0]
  RED   = [ 255,0,0]
  GREEN = [ 0,255,0]
  BLUE  = [ 0,0,255]
  WHITE = [ 255,255,255]
  YELLOW = [ 255,255, 0]

  def initialize(window)
    @renderer = window.create_renderer(-1, 0)

    @font = SDL2::TTF.open("fonts/FUTRFW.TTF", 20)
    @font.hinting = SDL2::TTF::Hinting::NORMAL
    # @font.style = SDL2::TTF::Style::BOLD
    @font.outline = 0
    @font.kerning = true
  end

  def clear!
    @renderer.draw_color = BLACK
    @renderer.clear
  end

  def show!
    @renderer.present
  end

  # TODO: Cache textures!
  def text(message, where, color: WHITE)
    solid   = @font.render_solid(message, color)
    texture = @renderer.create_texture_from(solid)
    rectangle = SDL2::Rect.new where.x, where.y, texture.w, texture.h
    @renderer.copy(texture, nil, rectangle)
  end

  def line(a,b, color)
    @renderer.draw_color = color
    @renderer.draw_line(a.x, a.y, b.x, b.y)
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

  def draw_square(a, color = [255,0,0], size = 4)
    @renderer.draw_color = color
    rect = SDL2::Rect.new(a.x - size, a.y - size, size*2, size*2)
    @renderer.fill_rect(rect)
  end

  def draw_rect(a, color = [255,0,0], size = 4)
    @renderer.draw_color = color
    rect = SDL2::Rect.new(a.x - size, a.y - size, size*2, size*2)
    @renderer.draw_rect(rect)
  end

end
