class Game

  def initialize(plan:, mouse:)
    @plan = plan
    @mouse = mouse

    @balls = [
      Ball.new(start: plan.points.sample, color: Pen::RED, speed: 0.005),
      Ball.new(start: plan.points.sample, color: Pen::GREEN, speed: 0.03),
      Ball.new(start: plan.points.sample, color: Pen::BLUE, speed: 0.04),
      Ball.new(start: plan.points.sample, color: Pen::YELLOW, speed: 0.01)      
    ]
  end

  def mouse_down(event)
  end

  def mouse_up(event)
  end

  def key_down(event)
  end

  def update
    @balls.each(&:update)
  end

  def draw(pen)
    @plan.draw(pen)
    @balls.each { |b| b.draw(pen) }
  end



end
