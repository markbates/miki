module Mack
  module ViewHelpers
    module ApplicationHelper
      # Anything in this module will be included into all views
      
      def rc(text)
        html = RedCloth.new(text, [:filter_html, :no_span_caps]).to_html
      end
      
    end
  end
end
