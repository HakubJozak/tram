require "ostruct"


class Plan

  attr_reader :points, :segments

  def initialize(plan = nil)
    @points   = []
    @segments = []
    copy_from(plan) if plan
  end

  def draw(pen)
    draw = -> (p) { p.draw(pen) }
    @segments.each(&draw)
    @points.each(&draw)
  end

  def empty?
    @segments.empty?
  end

  def to_h
    { segments: @segments.map(&:to_h) }
  end

  def add(thing)
    if thing.is_a? Segment
      @segments << thing
    else
      unless p = @points.find { |p| thing.x == p.x && thing.y == p.y }
        @points << thing
        thing
      else
        p
      end
    end
  end

  def remove(thing)
    case thing
    when Segment::ControlPoint
      @segments.delete thing.segment
    when Vertex
      thing.segments.each { |s| @segments.delete(s) }
      @points.delete thing
    else
      # Not part of the plan
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

  def each_segment(&block)
    @segments.each(&block)
  end

  def each(type, &block)
    # return enum_for(:each_point) unless block_given?

    @points.each   { |p| yield(p) }

    unless type == :vertex
      @segments.each {  |s| yield(s.control) }
    end
  end

  private

    def copy_from(plan)
      # if plan.respond_to? :points
      # end

      plan[:segments].each do |s|
        a = add(Vertex.new s[:a])
        b = add(Vertex.new s[:b])
        add Segment.new(a: a,
                        b: b,
                        name: s[:name],
                        control: OpenStruct.new(s[:control]))
      end
    end

end
