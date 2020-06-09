module Othello
    class Cell
        attr_accessor :value
        def initialize(value = " ")
            #cell starts blank
            @value = value
            #lets value be assigned later
        end
    end
end

