class Array
    def all_empty?
        self.all? { |element| element.to_s.empty? }
    end

    def any_empty?
        self.any? { |element| element.to_s.empty?}
    end

    def none_empty?
        !any_empty
    end

    def moves? 

    end

    def draw?

    

end
