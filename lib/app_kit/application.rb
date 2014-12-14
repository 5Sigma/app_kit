class AppKit::Application
  attr_accessor :dashboard
  attr_accessor :config
  attr_accessor :resources
  attr_accessor :navigation_resources

  def initialize
    @config = AppKit::Configuration.new
    @resources = []
    @navigation_resources = []
  end

end
