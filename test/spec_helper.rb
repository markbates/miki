require 'rubygems'
require 'pathname'
gem 'RedCloth', '4.0.3'
require 'redcloth'
require 'spec'

module RedCloth::Formatters
  
end

ENV["MACK_ENV"] = "test"
ENV["MACK_ROOT"] = File.join(File.dirname(__FILE__), "..")
load(File.join(File.dirname(__FILE__), "..", "Rakefile"))
require 'mack'

