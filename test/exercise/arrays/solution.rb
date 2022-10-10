module Exercise
  module Arrays
    class << self
      def replace(array)
        highest_num = array.reduce(0) { |current_highest_num, current_num| current_num > current_highest_num ? current_num : current_highest_num }
        array.map { |current_num| current_num >= 0 ? highest_num : current_num }
      end

      def search(array, query)
        return -1 if array.length.zero?

        mid = array.length / 2
        return mid if array[mid] == query
        return search(array[0...mid], query) if array[mid] > query

        res = search(array[(mid + 1)..], query)
        res == -1 ? -1 : mid + 1 + res
      end
      end
  end
end
