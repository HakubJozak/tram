module Tool
  class Base
    attr_reader :mouse, :plan

    def initialize(plan: , mouse: )
      @plan = plan
      @mouse = mouse
    end

    # NOOPs
    def update ; end
    def mouse_down(e) ;  end
    def mouse_up(e) ;  end
    def key_down(e) ;  end        
  end
end
