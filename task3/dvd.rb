require_relative 'library_item'

class DVD < LibraryItem
  attr_reader :genre

  def initialize(title, director, publication_year, genre)
    super(title, director, publication_year)
    @genre = genre
  end

  def director
    author
  end

  def display_info
    puts common_info
    puts "  Director: #{director}"
    puts "  Genre:    #{@genre}"
  end
end