module Mack
  module ViewHelpers
    module ApplicationHelper
      # Anything in this module will be included into all views
      
      def rc(text)
        html = RedCloth.new(text, [:filter_html, :no_span_caps]).to_html
      end
      
      def current_release
        # http://api.mackframework.com/mack/files/CHANGELOG.html
        uri = URI.parse("http://api.mackframework.com/mack/files/CHANGELOG.html")
        Net::HTTP.get_response(uri).body.match(/<h3>(.+)<\/h3>/).captures.first
      end
      
    end
  end
end
