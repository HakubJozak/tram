class Player

  def initialize(plan:, mouse:)
    @plan = plan
    @mouse = mouse

    @x = @plan.start
    @curve = @x.segments.first

    @speed = 0.02
    @direction = 1
    @t = 0.0
  end
  
  def mouse_down(event)
  end

  def mouse_up(event)
  end

  def key_down(event)
  end
  
  def update
    if @t < 0.0
      switch_segment(@curve.a)
    elsif @t > 1.0
      switch_segment(@curve.b)
    else @t < 1.0 and @t > 0.0
      @t += @speed * @direction
      @x = @curve.bezier_at(@t)
    end
  end

  def draw(pen)
    @plan.draw(pen)
    pen.draw_square(@x, Pen::WHITE, 10)
  end

  private

  def switch_segment(endpoint)
    if following = endpoint.
                     segments.
                     select { |s| s != @curve }.
                     sample
      # jump to next
      @curve = following
      # nearest = [ @curve.a, @curve.b ].min { |p| p.dist2(@x) }
      if following.a == endpoint
        @direction = 1.0
        @t = 0.0
      else
        @direction = -1.0        
        @t = 1.0
      end
    else
      # reverse
      @speed = 0
    end
  end
  
end
