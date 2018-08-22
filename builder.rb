class Builder

  def initialize(plan:, mouse:)
    @plan = plan
    @mouse = mouse
    @tool = Tool::Creator.new(plan: plan, mouse: mouse)
  end

  def key_down(event)
    case event.scancode
    when SDL2::Key::Scan::F1
      @tool = Tool::Creator.new(plan: @plan, mouse: @mouse)

    when SDL2::Key::Scan::F2
      @tool = Tool::Mover.new(plan: @plan, mouse: @mouse)
    else
      # DEBUG
      puts "Scan: #{event.scancode}, #{event.mod}"
    end
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
