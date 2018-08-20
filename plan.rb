class Plan
  def initialize
    @points   = []
    @segments = []
  end

  def draw(pen)
    drawing = -> (p) { p.draw(pen) }
    @segments.each(&drawing)
    @points.each(&drawing)
  end

  def add(thing)
    if thing.is_a? Segment
      @segments << thing
    else
      @points << thing
    end
  end

  def nearest(origin, type: :all)
    threshold = 48
    nearest   = nil

    each(type) do |p|
      r = (p.x - origin.x) ** 2 + (p.y - origin.y) ** 2

      if r < threshold
        threshold = r
        nearest = p
      end
    end

    nearest
  end

  def each(type, &block)
    # return enum_for(:each_point) unless block_given?
    
    @points.each   { |p| yield(p) }

    unless type == :vertex
      @segments.each {  |s| yield(s.control) }
    end
  end



end
