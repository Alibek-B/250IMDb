require "nokogiri"
require "open-uri"

class FilmCollection
  attr_reader :films

  def self.from_wiki
    films = []
    doc = Nokogiri::HTML(URI.open("https://ru.wikipedia.org/wiki/250_%D0%BB%D1%83%D1%87%D1%88%D0%B8%D1%85_%D1%84%D0%B8%D0%BB%D1%8C%D0%BC%D0%BE%D0%B2_%D0%BF%D0%BE_%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B8_IMDb"))

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
