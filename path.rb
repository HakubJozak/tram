require_relative 'vector2'


class Path

  RED = [ 255,0,0]
  WHITE = [ 255,255,255]

  def initialize
    @points = []
    @controls = []
  end

  def <<(point)
    @points << point

    if @points.size > 1
      a = @points[-2]
      b = @points[-1]

      half = a + (b - a) * 0.5

      puts "Half: #{half}, Point: #{point}"
      
      @controls << half
    end

    point
  end

  def draw(pen)
    @points.each do |p|
      pen.draw_square(p, RED)
    end

    @controls.each do |p|
      pen.draw_square(p, WHITE)
    end    
  end

    #   qerp(@a,x,@b) do |x|
    #     draw_dot(x)
    #   end

    # @points.each do |p|
    #   renderer
    # end

  private

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


end
