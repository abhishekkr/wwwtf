# Wwwtf
wwwtf_all = File.join(File.dirname(File.expand_path __FILE__), '*', '*.rb')
Dir.glob(wwwtf_all).each {|lib| require lib}
wwwtf_all_all = File.join(File.dirname(File.expand_path __FILE__), '*', '*', '*.rb')
Dir.glob(wwwtf_all_all).each {|lib| require lib}
require 'xml-motor'
require 'time'

module Wwwtf

  def self.cache_king(url)
  end
end
