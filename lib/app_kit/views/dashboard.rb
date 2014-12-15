class AppKit::Views::Dashboard < AppKit::Views::Base
  attr_accessor :items
  def initialize
    @items = []
  end
  def table(resource, options={}, &block)
    options[:filter] = false
    super(resource, options, &block)
  end
end
