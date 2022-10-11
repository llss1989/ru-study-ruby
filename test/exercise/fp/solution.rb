require 'bigdecimal/util'

module Exercise
  module Fp
    class << self
      # Обратиться к параметрам фильма можно так:
      # film["name"], film["rating_kinopoisk"], film["rating_imdb"],
      # film["genres"], film["year"], film["access_level"], film["country"]
      def rating(array)
        kinopoisk_ratings_with_countries = array.each_with_object([]) do |film, acc|
          acc << film['rating_kinopoisk'].to_f if rating_positive?(film['rating_kinopoisk']) && made_in_more_two_countries?(film)
        end
        kinopoisk_ratings_with_countries.reduce(0.0, :+) / kinopoisk_ratings_with_countries.length
      end

      def rating_positive?(rating)
        return false if rating.nil?

        rating.to_d > 0.0.to_d
      end

      def made_in_more_two_countries?(film)
        return false if film['country'].nil?

        film['country'].split(',').length > 1
      end

      def chars_count(films, threshold)
        films.reduce(0) do |acc, film|
          acc += chars_count_of_film(film['name'], 'и') if rating_positive?(film['rating_kinopoisk']) && film['rating_kinopoisk'].to_f >= threshold.to_f
          acc
        end
      end

      def chars_count_of_film(film_name, needed_char)
        film_name.chars.reduce(0) do |acc, current_char|
          acc += 1 if current_char == needed_char
          acc
        end
      end
    end
  end
end
