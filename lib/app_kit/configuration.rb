class AppKit::Configuration
  attr_accessor :application_title, :authentication_enabled

  def initialize
    @authentication_enabled = true
  end
end
