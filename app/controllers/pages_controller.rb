class PagesController
  include Mack::Controller
  
  layout :wiki
  
  cache_pages :only => :display
  
  # GET /pages
  def index
    @pages = Page.all
  end

  # GET /pages/1
  def show
    @page = Page.get(params[:id])
    raise Miki::PageNotFoundError.new if @page.nil?
    redirect_to(wiki_page_url(:url => @page.url))
  end

  # GET /pages/new
  def new
    @page = Page.new(:url => params[:url], :author => (cookies[:author] ||= "Anonymous Coward"), :title => (params[:title] || params[:url]))
    @page.title = @page.title.titleize unless @page.title.blank?
  end

  # GET /pages/1/edit
  def edit
    @page = Page.get(params[:id])
    @page.author = (cookies[:author] ||= "Anonymous Coward")
  end

  # POST /pages
  def create
    @page = Page.new(params[:page])
    if @page.save
      cookies[:author] = @page.author
      Cachetastic::Caches::PageCache.delete("/" + @page.url)
      redirect_to(wiki_page_url(:url => @page.url))
    else
      render(:action, "new")
    end
  end

  # PUT /pages/1
  def update
    @page = Page.get(params[:id])
    if @page.update_attributes(params[:page])
      cookies[:author] = @page.author
      Cachetastic::Caches::PageCache.delete("/" + @page.url)
      redirect_to(wiki_page_url(:url => @page.url))
    else
      render(:action, "edit")
    end
  end

  # DELETE /pages/1
  def delete
    @page = Page.get(params[:id])
    @page.destroy
    redirect_to(pages_index_url)
  end
  
  def display
    @page = Page.first(:url => params[:url].downcase)
    raise Miki::PageNotFoundError.new if @page.nil?
    render(:action, :display)
  end

  def newest_pages
    limit = params[:limit] || 5
    @pages = Page.all(:order => [:created_at.desc], :limit => limit.to_i)
    render(:action, :newest_pages, :layout => false)
  end
  
  def recently_updated_pages
    limit = params[:limit] || 5
    @pages = Page.all(:order => [:updated_at.desc], :limit => limit.to_i)
    render(:action, :recently_updated_pages, :layout => false)
  end

end
