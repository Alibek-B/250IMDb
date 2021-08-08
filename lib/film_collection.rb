require "nokogiri"
require "open-uri"

class FilmCollection
  attr_reader :films

  def self.from_wiki
    films = []
    doc = Nokogiri::HTML(URI.open("https://clck.ru/9HXwE"))

    doc.css("tbody tr")[1..250].map do |film|
      title = film.css("td")[1].content
      year = film.css("td")[2].content
      director = film.css("td")[3].content

      films << Film.new(
        title: title,
        director: director,
        year: year
      )
    end

    new(films)
  end

  def initialize(films)
    @films = films
  end

  def directors
    @films.map(&:director).uniq
  end

  def list_directors
    directors.map.with_index(1) do |director, index|
      "#{index}. #{director}"
    end
  end

  def choice_directors(director)
    @films.select do |film|
      film.director == director
    end.sample
  end
end
