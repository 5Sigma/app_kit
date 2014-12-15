  class AppKit::User < ActiveRecord::Base
    devise :database_authenticatable, :recoverable, :validatable, stretches: 2

    def to_s
      "#{first_name} #{last_name}"
    end
  

    def versions
      PaperTrail::Version.where(whodunnit: self.id).order(:created_at).limit(20)
    end


  end

