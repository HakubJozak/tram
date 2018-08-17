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

  def to_s
    "[#{@x},#{y}]"
  end


  # def +=(b)
  #   self[0] += b[0]
  #   self[1] += b[1]
  #   self
  # end

end
