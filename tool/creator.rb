module Tool
  class Creator < Tool::Base
    # def initialize(*args)
    #   super
    #   @last = nil
    # end

    def draw(pen)
      if @focus
        pen.line(@mouse, @focus, Pen::WHITE)
        pen.draw_square(@focus, Pen::GREEN)
      end

      pen.draw_cross(@mouse, Pen::YELLOW)
    end

    def mouse_down(e)
    end

    def mouse_up(e)
      if e.button == 1
        old_point = @plan.nearest(@mouse, type: :vertex)

        if @focus && old_point
          connect_points(old_point, @focus)
          @focus = old_point
        elsif @focus && old_point.nil?
          new_point = add_point(e)
          connect_points(new_point, @focus)
          @focus = new_point
        else
          @focus = add_point(e)
        end
      elsif e.button == 3
        @focus = nil
      end

      self
    end

    private

    def connect_points(a,b)
      @plan.add Segment.new(a: a, b: b)
    end

    def add_point(coords)
      new_point = @plan.add Vertex.new(coords)

      if @focus

      end

      new_point
    end

  end
end
