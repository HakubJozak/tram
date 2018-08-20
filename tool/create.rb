module Tool
  class Create < Tool::Base
    # def initialize(*args)
    #   super
    #   @last = nil
    # end

    def draw(pen)
      if @focus
        pen.draw_square(@focus, Pen::GREEN)
      end
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
      @plan.add Segment.new(a,b)
    end

    def add_point(coords)
      new_point = Vertex.new(coords)
      @plan.add new_point

      if @focus
        @plan.add Segment.new(@focus, new_point)
      end

      new_point
    end
    
  end
end
