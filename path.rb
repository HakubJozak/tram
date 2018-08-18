require_relative 'vector2'


class Path

  def initialize
    @points = []
    @controls = []
  end

  def remove(point)
    # @controls.delete(point)
    i = @points.index(point)

    if i >= 0
      a = @points[i-1]
      b = @points[i+1]

      if a && b
        @controls[i] = a + (b-a) * 0.5
      end
      
      @controls.delete_at(i-1)
      @points.delete_at(i)
    end
  end

  def <<(point)
    @points << point

    if @points.size > 1
      a = @points[-2]
      b = @points[-1]

      half = a + (b - a) * 0.5

      @controls << half
    end

    self
  end





end
