require "sdl2"

class Mouse

  extend Forwardable

  def_delegators :state, :x, :y


  def initialize
  end

  def state
    SDL2::Mouse.state
  end

  def draw(pen)
    pen.draw_cross(state, [255,255,255])
    # if @selected
    #   pen.draw_square(state, [255,255,255])
    # else
    # end
  end


end
