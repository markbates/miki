configatron do |c|
  c.namespace(:mack) do |mack|
    mack.session_id = '_miki_session_id'
    mack.js_framework = :prototype
  end
  c.default_secret_key = '4K45YJ5ZZQRX3QYW5KBEHC5LSH7G4X7ZLZNFDN4W6PD87BE4D487D7DXGM7SRP4ETNCPWPDEHW8RYF86'
end