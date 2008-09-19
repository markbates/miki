require 'logger'
configatron.mack.site_domain = 'http://www.mackwiki.com'
configatron.mack.caching.use_page_caching = true
configatron.cachetastic_default_options.debug = false
configatron.cachetastic_default_options.adapter = :memcache
configatron.cachetastic_default_options.marshall_method = :none
configatron.cachetastic_default_options.default_expiry = 24.hours
configatron.cachetastic_default_options.expiry_swing = 15.minutes
configatron.cachetastic_default_options.store_options.c_threshold = '10_000'
configatron.cachetastic_default_options.store_options.compression = true
configatron.cachetastic_default_options.store_options.debug = false
configatron.cachetastic_default_options.store_options.readonly = false
configatron.cachetastic_default_options.store_options.urlencode = false
configatron.cachetastic_default_options.servers = ['127.0.0.1:11211']
log_2 = Logger.new(Mack::Paths.log("cachetastic.log"))
log_2.level = Logger::ERROR
configatron.cachetastic_default_options.logger = [log_2]