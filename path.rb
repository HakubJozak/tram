require_relative 'vector2'


class Path

  RED = [ 255,0,0]
  WHITE = [ 255,255,255]
  YELLOW = [ 255,255, 0]  

  def initialize
    @points = []
    @controls = []
  end

  def remove(point)
    # @controls.delete(point)
    @points.delete(point)
  end

  def <<(point)
    @points << point

    if @points.size > 1
      a = @points[-2]
      b = @points[-1]

      half = a + (b - a) * 0.5

      @controls << half
    end

    point
  end

  def draw(pen)
    @controls.each.with_index do |x,i|
      a = @points[i]
      b = @points[i+1]

      if a && b
        qerp(a,x,b) do |c|
          pen.draw_dot(c, YELLOW)
        end
      end
      
      pen.draw_rect(x, WHITE)
    end    
    
    @points.each do |p|
      pen.draw_rect(p, RED)
    end    
  end

  def each_point(&block)
    @points.each   { |p| yield(p) }
    @controls.each { |p| yield(p) }    
  end

    #   qerp(@a,x,@b) do |x|
    #     draw_dot(x)
    #   end

    # @points.each do |p|
    #   renderer
    # end

  def find_nearest(origin)
    threshold = 48
    nearest   = nil
    
    each_point do |p|
      r = (p.x - origin.x) ** 2 + (p.y - origin.y) ** 2

      if r < threshold
        threshold = r
        nearest = p
      end
    end

    nearest
  end
  
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
      t += 0.01
    end
  end


end
