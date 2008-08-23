module Miki
  module CommonHelpers
    
    def clean_url(url)
      # url = url.to_s
      # url = url[1..url.size] if url.starts_with?('/')
      # url.gsub!(' ', '_')
      url.methodize.downcase
    end
    
    include_safely_into(Mack::Rendering::ViewTemplate, Mack::Controller, DataMapper::Resource)
    
  end
end