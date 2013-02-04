# Wwwtf::Cache

module Wwwtf
  module Cache

    def self.cache_control_max_age(cache_control)
      return nil if cache_control.nil?
      cache_control.scan(/max-age\s*=\s*([0-9]*)/).flatten[0]
    end
  end
end
