class Player
    attr_accessor :name
    attr_reader :mark
    attr_accessor :at_turn
    def initialize(name, mark)
      @name = name
      @mark = mark
      @at_turn = false
    end
end