module Tool
  class Mover < Base
    def update

      # moving the selected point by mouse
      if @selected
        @selected.update(@mouse)
      end
    end

    def draw(pen)
      pen.text "Mover", Vector2.new(5,5)

      if @selected
        @selected.draw(pen, active: true)
      end

      pen.draw_cross(@mouse.state, Pen::WHITE)
    end

    def mouse_up(e)
      @selected = nil

      if e.button == 3
        puts 'remove'

        if nn = @plan.nearest(@mouse)
          @plan.remove(nn)
        end
      end
    end

    def mouse_down(e)
      if e.button == 1
        @selected = @plan.nearest(@mouse)
      end
    end
  end

end
