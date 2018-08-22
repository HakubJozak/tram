module Tool
  class Creator < Tool::Base
    # def initialize(*args)
    #   super
    #   @last = nil
    # end

    def draw(pen)
      if @focus
        pen.draw_square(@focus, Pen::GREEN)
      end

      pen.draw_cross(@mouse.state, Pen::YELLOW)      
    end

    def mouse_down(e)
      self
    end

    def mouse_up(e)
      if e.button == 1
        if nn = @plan.nearest(@mouse, type: :vertex)
          connect_points(nn, @focus) if @focus
          @focus = nn
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
        @plan.add Segment.new(a: @focus, b: new_point)
      end

      new_point
    end

  end
end
