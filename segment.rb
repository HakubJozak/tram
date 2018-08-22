class Segment

  extend Forwardable

  attr_reader :a, :b, :control

  def_delegators :@control, :x, :y

  def initialize(a:, b:, control: nil)
    @a = a
    @b = b

    @a.add_segment(self)
    @b.add_segment(self)

    @control = ControlPoint.new(segment: self, a: a, b: b, coords: control)
  end

  def to_h
    { a: @a.to_h,
      control: @control.to_h,
      b: @b.to_h,
      type: 'bezier' }
  end

  def draw(pen, hover: false, active: false)
    color = if active || hover
              Pen::GREEN
            else
              Pen::WHITE
            end

    bezier(@a,@control,@b) do |p|
      pen.draw_dot(p, color)
    end

    pen.draw_rect(@control, color)
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

      def initialize(a: nil, b: nil, segment: , coords: nil)
        if coords
          super coords
        elsif a && b
          super (a + b) * 0.5
        else
          fail "You have to specify either a,b or coords for ControlPoint"
        end

        @segment = segment
      end

      def draw(pen, hover: false, active: false)
        @segment.draw(pen, active: active, hover: hover)

        if hover
          pen.draw_square(self, Pen::GREEN)
        elsif active
          pen.draw_square(self, Pen::GREEN)          
        else
          pen.draw_rect(self, Pen::WHITE)
        end
      end
    end



end
