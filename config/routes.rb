Mack::Routes.build do |r|

  # r.with_options(:controller => :users) do |map|
  #   r.login "/users/login", :action => :login
  #   r.do_login "/users/do_login", :action => :do_login, :method => :post
  # end
  
  r.login "/users/login", :controller => :users, :action => :login
  r.do_login "/users/login", :controller => :users, :action => :do_login, :method => :post

  r.resource :users # Added by rake generate:scaffold name=user
  
  
  r.with_options(:controller => :pages) do |map|
    map.newest_pages "/pages/newest_pages/:limit", :action => :newest_pages
    map.recently_updated_pages "/pages/recently_updated_pages/:limit", :action => :recently_updated_pages
  end
  
  r.resource :pages # Added by rake generate:scaffold name=page
  
  r.handle_error Miki::PageNotFoundError, :controller => :pages, :action => :not_found
  
  r.wiki_page "/:url", :controller => :pages, :action => :display
  
  r.home_page "/", :controller => :pages, :action => :display, :url => "home"
  
  r.defaults
  
end
