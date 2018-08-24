class Vector2

  attr_accessor :x, :y

  def initialize(*args)
    if args.size == 1
      if args[0].respond_to? :fetch
        @x = args[0].fetch :x
        @y = args[0].fetch :y
      else
        @x = args[0].x
        @y = args[0].y
      end
    else
      @x = args[0]
      @y = args[1]
    end
  end

  def dist2(b)
    (x * b.x) + (y * b.y)
  end

  def to_h
    { x: @x, y: @y }
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

  def update(b)
    @x = b.x
    @y = b.y
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
