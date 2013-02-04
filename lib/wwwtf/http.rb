# Wwwtf::HTTP

module Wwwtf
  module HTTP

    def self.headers(url)
      hdrs = %x{curl -IkLs #{url}}
      headr = {}
      hdr = hdrs.split("\r\n")
      hdr = hdr.collect{|h| {h.split(':')[0].strip => h.split(':')[1..-1].join.strip} }
      hdr.each{|h| headr = headr.merge h}
      headr
    end

    def self.body(url)
      %x{curl -kLs #{url}}
    end

    def self.page_dependency(url)
      body       = body url
      xtmp_nodes = XMLMotor.splitter body
      xtmp_tags  = XMLMotor.indexify xtmp_nodes
      tag_src    = XMLMotor.xmlattrib 'src', xtmp_nodes, xtmp_tags
      src_in_page = tag_src.uniq.collect{|src|
                      fix_urls url, src
                    }
      Wwwtf::HTTP::URL.uniq([url] + src_in_page).compact
    end

    def self.fix_urls(base_url, src_string)
      http = base_url.scan(/^(https*)\:\/\//).flatten.join
      if src_string.match(/^https*\:\/\//i)
        src_string
      elsif src_string.match(/^\/\//)
        "#{http}:#{src_string}"
      else
        File.join base_url, src_string
      end
    end
  end
end
