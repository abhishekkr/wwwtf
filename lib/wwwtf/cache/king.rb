# Wwwtf::Cache::King

module Wwwtf
  module Cache
    module King

      def self.stat(url)
        page_urls = Wwwtf::HTTP.page_dependency(url)
        all_headers = headers(page_urls)
        cache_control, last_modified = [], []
        all_headers.each do |url, headr|
          max_age = Wwwtf::Cache.cache_control_max_age(headr['Cache-Control'])
          cache_control.push max_age
          last_modified.push headr['Last-Modified']
        end
        {
          'total_count'                => page_urls.size,
          'cache_control%'             => cache_control_percent(cache_control),
          'expire_in_day%'             => expire_in_day_percent(cache_control),
          'last_modified%'             => last_modified_percent(last_modified),
          'last_modified_hours_median' => last_modified_median(last_modified)
        }
      end

      def self.headers(page_urls)
        headers     = {}
        page_urls.each do |src|
          headers = headers.merge({src => Wwwtf::HTTP.headers(src)})
        end
        filter_cache_headers(headers)
      end

      def self.filter_cache_headers(headers_batch)
        filtered_headers = {}
        reqd_headers     = ['Cache-Control', 'Last-Modified']
	headers_batch.each do |url, headers|
          filtered = {}
          reqd_headers.each {|hdr|
            filtered = filtered.merge(
                         {hdr => headers[hdr]}
                       )
          }
          filtered_headers = filtered_headers.merge( {url => filtered} )
        end
        filtered_headers
      end

      def self.cache_control_percent(cache_control)
        (cache_control.compact.size * 100) / cache_control.size
      end

      def self.expire_in_day_percent(cache_control)
        max_age_in_days = cache_control.compact.collect{|max_age|
                            max_age.to_i / 86400 # i.e. 60 * 60 * 24
                          }
        max_age_in_days.delete(0)
        (max_age_in_days.size * 100 ) / cache_control.size
      end

      def self.last_modified_percent(last_modified)
        (last_modified.compact.size * 100) / last_modified.size
      end

      def self.last_modified_median(last_modified)
        require 'time'
        last_modified   = last_modified.compact
        last_mod_sorted = last_modified.each {|mod_time|
                            Time.parse(mod_time)
                          }.sort
        half_size = last_mod_sorted.size / 2
        if ( last_mod_sorted.size % 2 ) == 0
          median_mod_time = Wwwtf::UtilsTime.hours_until_now(
                              last_mod_sorted[half_size]
                            )
          median_mod_time += Wwwtf::UtilsTime.hours_until_now(
                               last_mod_sorted[half_size - 1]
                             )
          median_mod_time = median_mod_time / 2
        else
          median_mod_time = Wwwtf::UtilsTime.hours_until_now(
                              last_mod_sorted[half_size]
                            )
        end
        median_mod_time
      end
    end
  end
end
