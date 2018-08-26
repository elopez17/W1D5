class Map
#  set(key, value), get(key), delete(key), show
  def initialize
    attr_reader :dictionary
    def initialize
      @dictionary = []
    end

    def set(key, value)
      pair_index = @dictionary.index { |pair| pair[0] == key }
      if pair_index
        @dictionary[pair_index][1] = value
      else
        @dictionary.push([key, value])
      end
      value
    end

    def get(key)
      @dictionary.each do |sub_arr|
        if sub_arr.first == key
          return sub_arr.last
        end
      end
      nil
    end

    def delete(key)
      value = get(key)
      @dictionary.delete_if { |sub_arr| sub_arr.first == key }
      value
    end

    def show
      deep_dup(@dictionary)
    end

    def deep_dup(arr)
      arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
    end
  end
end
