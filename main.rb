require_relative "lib/film"
require_relative "lib/film_collection"

puts "Программа «Фильм на вечер»"

collection = FilmCollection.from_wiki

puts collection.list_directors

puts
puts "Выберите режиссера из списка:"
print "> "
input = gets.to_i

director = collection.directors[input - 1]

if input.between?(1, collection.directors.size)
  puts "И сегодня вечером рекомендую посмотреть: "
  puts  collection.choice_directors(director)
else
  puts "Нет такого режиссера"
end
