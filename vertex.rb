class Vertex < Vector2

  attr_reader :segments

  def initialize(*args)
    super
    @segments = []
  end

  def add_segment(s)
    @segments << s
  end



end
