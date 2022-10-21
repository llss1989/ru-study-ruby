module Exercise
  module Fp2
    class MyArray < Array
      # Использовать стандартные функции массива для решения задач нельзя.
      # Использовать свои написанные функции для реализации следующих - можно.

      # Написать свою функцию my_each

      def my_each(&block)
        return self if empty?

        first, *rest = self
        yield first
        arr_without_first = MyArray.new(rest)
        arr_without_first.my_each(&block)
        self
      end

      # Написать свою функцию my_map
      def my_map
        if block_given?
          MyArray.new(my_reduce([]) { |acc, current_el| acc.push(yield current_el) })
        else
          to_enum :my_map
        end
      end

      # Написать свою функцию my_compact
      def my_compact
        MyArray.new(my_reduce([]) do |acc, current_el|
                      acc << current_el unless current_el.nil?
                      acc
                    end)
      end

      # Написать свою функцию my_reduce
      def my_reduce(arg = nil, &block)
        current_acc =  arg.nil? ? self[0] : arg
        puts  current_acc.class
        # puts current_acc
        starting_array = arg.nil? ? self[1..] : self
        iter = lambda { |array, acc, &innerblock|
          return acc if array.empty?

          first, *rest = array
          acc = yield(acc, first)
          return iter.call(rest, acc, &innerblock)
        }
        iter.call(starting_array, current_acc, &block)
      end
    end
  end
end
