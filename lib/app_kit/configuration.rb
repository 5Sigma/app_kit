class AppKit::Configuration
  attr_accessor :application_title, :authentication_enabled

  def initialize
    @authentication_enabled = true
  end

  def authentication_enabled?
    authentication_enabled
  end
end
