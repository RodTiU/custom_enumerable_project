module Enumerable
  # Your code goes here
  def my_each_with_index
    index = 0
    for value in self
      yield value, index
      index += 1
    end
  end

  def my_select
    array_filter = []
    my_each { |value| array_filter << value if yield value }
    array_filter
  end

  def my_all?
    count = 0
    my_each { |value| count += 1 if yield value }
    count === self.length
  end

  def my_any?
    count = 0
    my_each { |value| count += 1 if yield value }
    count > 0
  end

  def my_none?
    count = 0
    my_each { |value| count += 1 if yield value }
    count === 0
  end

  def my_count
    return self.size unless block_given?
    count = 0
    my_each { |value| count += 1 if yield value }
    count
  end

  def my_map
    array_map = []
    my_each { |value| array_map << yield(value) }
    array_map
  end

  def my_inject(initial_value)
    my_array = self
    loop do
      reduction_array = []
      my_array.my_each_with_index do |value, index|
        if my_array.length - 1 <= index && index % 2 == 0
          reduction_array << yield(value, 0)
          break
        elsif index % 2 == 0
          reduction_array << yield(value, my_array[index + 1])
        end
      end
      my_array = reduction_array
      my_array[-1] = self[-1] if my_array[-1] == 0

      # add initial_value condition
      if reduction_array.length == 1
        my_array << initial_value
        break
      end
    end

    yield(*my_array)
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    for value in self
      yield value
    end
  end
end

p [1, 1, 2, 3, 5, 8, 13, 21, 34].my_inject(1) { |value, n| value * n }
