require_relative 'library_item'

class Book < LibraryItem
  attr_reader :genre

  def initialize(title, author, publication_year, genre)
    super(title, author, publication_year)
    @genre = genre
  end

  def display_info
    puts common_info
    puts "  Author: #{author}"
    puts "  Genre:  #{@genre}"
  end
end