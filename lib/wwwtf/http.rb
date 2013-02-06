# Wwwtf::HTTP

module Wwwtf
  module HTTP

    class << self
      attr_accessor :curl_headers
    end
    @curl_headers = 'User Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.4 (KHTML, Linuxke Gecko) Chrome/22.0.1229.52 Safari/537.4'

    def self.headers(url)
      hdrs = %x{curl -IkLs -H '#{curl_headers}' #{url}}
      headr = {}
      return headr if hdrs.match(/HTTP\/1\.[01]\s*[45][0-9][0-9]\s*\w/)
      hdr = hdrs.split("\r\n")
      hdr = hdr.collect{|h| {h.split(':')[0].strip => h.split(':')[1..-1].join.strip} }
      hdr.each{|h| headr = headr.merge h}
      headr
    end

    def self.body(url)
      %x{curl -kLs -H '#{curl_headers}' #{url}}
    end

    def self.page_dependency(url)
      page_content = body url
      xtmp_nodes   = XMLMotor.splitter page_content
      xtmp_tags    = XMLMotor.indexify xtmp_nodes
      tag_src      = XMLMotor.xmlattrib 'src', xtmp_nodes, xtmp_tags
      src_in_page = tag_src.uniq.collect{|src|
                      fix_urls url, src
                    }
      Wwwtf::HTTP::URL.uniq([url] + src_in_page).compact
    end

    def self.fix_urls(base_url, src_string)
      begin
        src_string = src_string.unescape.strip
        src_string = src_string[1..-2] if src_string.match(/^\".*\"$/)
        http = base_url.scan(/^(https*)\:\/\//).flatten.join
        if src_string.match(/^https*\:\/\//i)
          src_string
        elsif src_string.match(/^\/\//)
          "#{http}:#{src_string}"
        else
          File.join base_url, src_string
        end
      rescue
        puts "ERR: #{src_string}"
        return nil
      end
    end
  end
end
