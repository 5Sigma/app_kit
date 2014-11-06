  class AppKit::User < ActiveRecord::Base
    devise :database_authenticatable, :recoverable, :validatable, stretches: 2

    def to_s
      email
    end
  end

