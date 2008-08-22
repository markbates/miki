require 'rubygems'
require 'pathname'
gem 'RedCloth'
require 'redcloth'
require 'spec'

ENV["MACK_ENV"] = "test"
ENV["MACK_ROOT"] = File.join(File.dirname(__FILE__), "..")
load(File.join(File.dirname(__FILE__), "..", "Rakefile"))
require 'mack'

