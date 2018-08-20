class Vertex < Vector2

  attr_reader :segments

  def initialize(*args)
    super
    @segments = []
  end

  def add_segment(s)
    @segments << s
  end

  def draw(pen, hover: false)
    if hover
      pen.draw_square(self, Pen::RED)      
    else
      pen.draw_rect(self, Pen::RED)
    end
  end

end
