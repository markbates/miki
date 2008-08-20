Mack::Routes.build do |r|
  
  r.with_options(:controller => :pages) do |map|
    map.newest_pages "/pages/newest_pages/:limit", :action => :newest_pages
    map.recently_updated_pages "/pages/recently_updated_pages/:limit", :action => :recently_updated_pages
  end
  
  r.resource :pages # Added by rake generate:scaffold name=page
  
  r.handle_error Miki::PageNotFoundError, :controller => :pages, :action => :not_found
  
  r.wiki_page "/:url", :controller => :pages, :action => :display
  
  # r.home_page "/", :controller => :default, :action => :index
  r.home_page "/", :controller => :pages, :action => :display, :url => "home"
  # r.connect "/", :redirect_to => "/home"
  
  r.defaults
  
end
