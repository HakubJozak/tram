require "sdl2"

class Mouse

  extend Forwardable

  def_delegators :state, :x, :y


  def initialize
  end

  def state
    SDL2::Mouse.state
  end


end
