# Wwwtf::HTTP::URL

module Wwwtf
  module HTTP
    module URL

      def self.unroot(url)
        File.join File.dirname(url), File.basename(url)
      end

      def self.same(url1, url2)
        File.expand_path(url1) === File.expand_path(url2)
      end

      def self.uniq(urls)
        urls.collect{|url| unroot(url)}.uniq
      end
    end
  end
end
