class Plan
  def initialize
    @points   = []
    @segments = []
  end

  def draw(pen)
    @segments.each { |s| s.draw(pen) }
    @points.each { |p|
      pen.draw_rect(p, Pen::RED)
    }
  end

  def add(thing)
    if thing.is_a? Segment
      @segments << thing
    else
      @points << thing
    end
  end

  def nearest_vertex(origin)
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

  def each_point(&block)
    # return enum_for(:each_point) unless block_given?
    @points.each   { |p| yield(p) }
    @segments.each {  |s| yield(s.control) }    
  end
  


end
