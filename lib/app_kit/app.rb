class AppKit::App
  attr_accessor :dashboard
  attr_accessor :config

  def initialize
    @config = AppKit::Configuration.new
  end
end
