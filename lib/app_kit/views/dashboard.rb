class AppKit::Views::Dashboard < AppKit::Views::Base
  attr_accessor :items
  def initialize
    @items = []
  end
end
