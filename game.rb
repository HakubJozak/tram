class Game

  def initialize(plan:, mouse:)
    @plan = plan
    @mouse = mouse

    @balls = [
      Ball.new(plan: plan, color: Pen::RED, speed: 0.02),
      Ball.new(plan: plan, color: Pen::GREEN, speed: 0.03),
      Ball.new(plan: plan, color: Pen::BLUE, speed: 0.04)
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
