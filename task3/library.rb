require_relative 'library_item'

class Library
  def initialize
    @items = []
  end

  def add_item(item)
    raise ArgumentError, "Only LibraryItem objects can be added" unless item.is_a?(LibraryItem)
    @items << item
  end

  def remove_item(title)
    removed = @items.reject! { |item| item.title == title }
    puts removed ? "Removed \"#{title}\"" : "No item titled \"#{title}\""
  end

  def display_item(item)
    item.display_info
  end

  def display_all_items
    puts "Library has #{@items.size} item(s):"
    @items.each { |item| display_item(item) }
  end
end