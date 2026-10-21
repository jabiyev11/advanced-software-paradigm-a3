require_relative 'library_item'

class CD < LibraryItem
  attr_reader :genre

  def initialize(title, artist, publication_year, genre)
    super(title, artist, publication_year)
    @genre = genre
  end

  def artist
    author
  end

  def display_info
    puts common_info
    puts "  Artist: #{artist}"
    puts "  Genre:  #{@genre}"
  end
end