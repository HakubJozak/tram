class Naming
  
  def initialize
    @letters = ("A".."Z").to_a
    @numbers = (1..9).to_a.map(&:to_s)
    @l = 0
    @n = 0
  end

  def next
    if @n == @numbers.size - 1
      @n = 0
      # FIX: letters run out
      @l += 1
      @l = @l % @letters.size
    else
      @n += 1
    end

    r = [ @letters[@l], @numbers[@n] ].join
    puts r

    r
  end


    

end
