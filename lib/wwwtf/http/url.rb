# Wwwtf::HTTP::URL

module Wwwtf
  module HTTP
    module URL

      def self.unroot(url)
        File.join File.dirname(url), File.basename(url)
      end

      def self.same(url1, url2)
        url1 = url1.gsub(/^https*\:\/\//, '')
        url2 = url2.gsub(/^https*\:\/\//, '')
        File.expand_path(url) === File.expand_path(url2)
      end

      def self.uniq(urls)
        urls.collect{|url| unroot(url)}.uniq
      end
    end
  end
end
