class LibraryItem
  attr_reader :title, :author, :publication_year

  def initialize(title, author, publication_year)
    @title = title
    @author = author
    @publication_year = publication_year
  end

  def display_info
    puts common_info
  end

  protected

  def common_info
    "#{self.class.name}: \"#{@title}\" (#{@publication_year})"
  end
end