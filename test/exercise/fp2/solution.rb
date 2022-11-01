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
          MyArray.new(my_reduce([]) { |acc, current_el|
          acc.push(yield current_el) 
        })
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

      def my_reduce(acc = nil, &block)
        return acc if empty? || length == 0
        new_acc = acc.nil? ? first : block.call(acc, first)
        MyArray.new(self[1..]).my_reduce(new_acc, &block)
      end  
    end
  end
end
