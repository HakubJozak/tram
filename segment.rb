class Segment

  extend Forwardable

  attr_reader :a, :b, :control

  def_delegators :@control, :x, :y

  def initialize(a,b)
    @a = a
    @b = b

    @a.add_segment(self)
    @b.add_segment(self)

    @control = ControlPoint.new(@a, @b, self)
  end

  def draw(pen)
    bezier(@a,@control,@b) do |p|
      pen.draw_dot(p, Pen::YELLOW)
    end

    pen.draw_rect(@control, Pen::WHITE)
  end

  private

    def bezier(a,b,c, &block)
      t = 0.0

      while t < 1.0
        q1 = a * ((1-t)**2)
        q2 = b * (2*(1-t) * t)
        q3 = c * (t**2)
        yield q1 + q2 + q3
        t += 0.01
      end
    end

    class ControlPoint < Vector2
      attr_reader :segment

      def initialize(a, b, segment)
        super (a + b) * 0.5
        @segment = segment
      end

      def draw(pen, hover: false)
        if hover
          pen.draw_square(self, Pen::WHITE)      
        else
          pen.draw_rect(self, Pen::WHITE)
        end
      end
    end



end
