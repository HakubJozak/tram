class Builder

  def initialize(plan:, mouse:)
    @tool = Tool::Create.new(plan: plan, mouse: mouse)
  end

  def mouse_down(event)
    @tool = @tool.mouse_down(event)
  end

  def mouse_up(event)
    @tool = @tool.mouse_up(event)
  end

  def draw(pen)
    @tool.draw(pen)
  end

end
