module Tool
  class Base
    attr_reader :mouse, :plan

    def initialize(plan: , mouse: )
      @plan = plan
      @mouse = mouse
    end
  end
end
