  class AppKit::User < ActiveRecord::Base
    devise :database_authenticatable, :recoverable, :validatable, stretches: 2

    def to_s
      if first_name || last_name
      "#{first_name} #{last_name}"
      else
        email
      end
    end

    def versions
      PaperTrail::Version.where(whodunnit: self.id).order(:created_at => :desc).limit(20)
    end


  end

