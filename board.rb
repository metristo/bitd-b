module TicTacToe
    class Board
      def initialize(input)
        @grid = input.fetch(:grid)
        @cells = Array.new(size) {Array.new(size, Cell.new)}
      end

      private 

      def get_cell (x, y)
        grid[x][y]
      end

      def set_value (x, y, player)
        get_cell(x, y).value = value
      end

      def game_over
        return :winner if winner?
        return :draw if draw?
        false
      end

      def place_piece (x, y, player)
        @cells[x][y] = Cell.new(player)
        flip(x, y, player)
      end

      def flip(x, y, player)
        pieces = []
        for i in [-1, 0, 1]
            for j in [-1, 0, 1]
                to_flip = flippable(x+i, y+j, i, j, player)
                if to_flip.length != 0
                    for x,y in to_flip
                        @cells[x][y].flip(player)
                        #this shit needs a lot of work to be .each
                    end
                end
            end
        end
    end

    def flippable(x, y, x_offset, y_offset, player)
        flip = []
        if in_bounds?(x, y)
            if @cells[x][y].occupied? and !@cells[x][y].owner?(player)
                while in_bounds?(x, y) && @cells[x][y].occupied?
                    return flip if @cells[x][y].owner?(player)
                    flip << [x,y]
                    x += x_offset
                    y += y_offset
                end
            end
        end
        return []
    end

    def legal?(x, y, player)
        return false if @cells[x][y].occupied?
        legal = false
        for i in [-1, 0, 1]
            for j in [-1, 0, 1]
                if !(i== 0 and j == 0)
                    legal |= !flippable(x+1, y+j, i, j, player).empty?
                end
            end
        end
        return legal
    end

    def count_pieces(player)
        count = 0
        for i in (0..@size-1)
            for j in (0..@size-1)
                count += 1 if @cells[i][j].owner?(player)
            end
        end
        return count
    end

    def display_board
        print "   "
        (0..(@size-1)).map{ |i| print "#{i+1}" + ((i < @size - 1) ? ", " : " ")}
        print "\n"
        (0..(@size-1)).map { |i| puts "#{i+1} #{@cells[i].inspect}" }
    end

    def in_bounds?(x, y)
        return valid_row?(x) && valid_row?(y)
    end

    def valid_row?(x)
        return x >= 0 && x < @size
    end

    def valid_col?(y)
        return y >= 0 && y < @size
    end

    def get_size
        return @size
    end

end