require 'logger'
configatron do |c|
  c.namespace(:mack) do |mack|
    mack.site_domain = 'http://www.mackwiki.com'
    mack.namespace(:log) do |log|
      log.level = :error
    end
    mack.namespace(:caching) do |caching|
      caching.use_page_caching = true
    end
  end
  c.default_secret_key = '4K45YJ5ZZQRX3QYW5KBEHC5LSH7G4X7ZLZNFDN4W6PD87BE4D487D7DXGM7SRP4ETNCPWPDEHW8RYF86'
  c.namespace(:cachetastic_default_options) do |cdo|
    cdo.debug = false
    cdo.adapter = :memcache
    cdo.marshall_method = :none
    cdo.default_expiry = 24.hours
    cdo.expiry_swing = 15.minutes
    cdo.store_options = {
      :c_threshold => "10_000",
      :compression => true,
      :debug => false,
      :readonly => false,
      :urlencode => false
    }
    cdo.servers = ["127.0.0.1:11211"]

    log_2 = Logger.new(Mack::Paths.log("cachetastic.log"))
    log_2.level = Logger::ERROR
    cdo.logger = [log_2]
  end
end