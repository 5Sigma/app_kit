  class AppKit::User < ActiveRecord::Base
    devise :database_authenticatable, :recoverable, stretches: 2


    def to_s
      email
    end
  end

