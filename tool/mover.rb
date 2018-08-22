module Tool
  class Mover < Base
    def update
      # moving the selected point by mouse
      if @selected
        @selected.update(@mouse)
      end
    end

    def draw(pen)
      if @selected
        @selected.draw(pen, active: true)
      end

      pen.draw_cross(@mouse.state, Pen::WHITE)
    end

    def mouse_up(e)
      @selected = nil
    end

    def mouse_down(e)
      @selected = @plan.nearest(@mouse)
    end
  end

end
