class Ball

  def initialize(start: , color:, speed:)
    @color = color
    @speed = speed

    @direction = 1
    @t = 0.0    
    @x = start
    @curve = @x.segments.first
  end

  def draw(pen)
    pen.draw_square(@x,@color, 10)
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
        @direction *= -1
      end
    end
  

end
