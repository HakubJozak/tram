class Builder

  def initialize(plan:, mouse:)
    @plan = plan
    @mouse = mouse
    @tool = Tool::Creator.new(plan: plan, mouse: mouse)
  end

  def tool=(t)
    @tool = t
  end

  def mouse_down(event)
    @tool.mouse_down(event)
  end

  def mouse_up(event)
    @tool.mouse_up(event)
  end

  def update
    @tool.update
  end

  def draw(pen)
    @plan.draw(pen)
    @tool.draw(pen)

    if nn = @plan.nearest(@mouse)
      nn.draw(pen, hover: true)
    end
  end

end
