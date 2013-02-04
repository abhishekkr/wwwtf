# Wwwtf::Utils::Time

module Wwwtf
  module UtilsTime

    def self.hours_until_now(time)
      begin
        (Time.now - Time.parse(time)).to_i / 3600
      rescue
        msg = time.nil? ? 'NIL Times' : "Bad Times #{time}"
        puts "This app has seen #{msg}"
        exit 1
      end
    end
  end
end
