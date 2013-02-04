# Wwwtf
wwwtf_all = File.join(File.dirname(File.expand_path __FILE__), '*', '*.rb')
Dir.glob(wwwtf_all).each {|lib| require lib}
wwwtf_all_all = File.join(File.dirname(File.expand_path __FILE__), '*', '*', '*.rb')
Dir.glob(wwwtf_all_all).each {|lib| require lib}
require 'xml-motor'
require 'time'

module Wwwtf

  def self.cache_king(url)
    cache_stat = Wwwtf::Cache::King.stat url
    lm_median_hrs = cache_stat['last_modified_hours_median']
    lm_median_days = lm_median_hrs / 24
    puts "#{url} has:
          #{cache_stat['total_count']} number of dependent content locations,
          #{cache_stat['cache_control%']}% of it is Cache-Control decisive,
          #{cache_stat['expire_in_day%']}% of cached expires within a day,
          #{cache_stat['last_modified%']}% is aware of Last-Modified,
          #{lm_median_hrs}hrs. (i.e. #{lm_median_days} days) is L-M median
         "
    puts "\tDependent URLs:\n\t#{cache_stat['page_urls'].join("\n\t")}\n" unless ENV['WWWTF_DEBUG'].nil?
  end
end
