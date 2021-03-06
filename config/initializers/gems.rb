# Using this file you can add gems dependencies to your application.
# gem_name, options
# gem_name is the name of the gem you want to add.
# :version, optional, is the version of the gem you want to use.
# :libs, optional, is an array of files you want to require.
# :source, options, is the source you want to use to install a particular gem.
require_gems do |gem|
  gem.add "mack-data_mapper", :libs => "mack-data_mapper"
  gem.add "mack-data_factory", :libs => "mack-data_factory"
  gem.add "mack-javascript", :libs => "mack-javascript"
  gem.add "mack-caching", :libs => "mack-caching"
  gem.add "RedCloth", :version => "4.0.3", :libs => :redcloth
  # examples:
  # gem.add :redgreen, :version => "1.2.2", :libs => :redgreen
  # gem.add :termios
  # gem.add :rubyzip, :source => "http://gems.rubyforge.org"
end
