# Wwwtf::Utils::Time

module Wwwtf
  module UtilsTime

    def self.hours_until_now(time)
      (Time.now - Time.parse(time)).to_i / 3600
    end
  end
end
