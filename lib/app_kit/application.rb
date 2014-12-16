class AppKit::Application
  attr_accessor :dashboard
  attr_accessor :config
  attr_accessor :resources
  attr_writer :navigation_items

  def initialize
    @config = AppKit::Configuration.new
    @resources = []
    @navigation_items = []
  end

  def navigation_items(position = :all)
    return @navigation_items if position == :all
    navigation_items.select { |i| i.position == position }
  end

end
