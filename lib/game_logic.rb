class GameLogic
  @initial_array = nil

  def initialize()
  @initial_array = [[5, 0, 1],
                    [0, 5, 6],
                    [5, 8, 5]]
  end

  def test_winner_diagonal
    if @initial_array[0][0] == @initial_array[1][1] &&
       @initial_array[1][1] == @initial_array[2][2]
      return true
    elsif @initial_array[0][2] == @initial_array[1][1] &&
          @initial_array[1][1] == @initial_array[2][0]
      return true
    end

    false
  end

  def test_winner
    @initial_array.each do |row|
      return true if row.all? { |i| i == row[0] }
    end
    transposed = @initial_array.transpose
    transposed.each do |column|
      return true if column.all? { |i| i == column[0] }
    end

    test_winner_diagonal
  end
end

p GameLogic.new.test_winner

