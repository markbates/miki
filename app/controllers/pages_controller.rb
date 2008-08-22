class PagesController
  include Mack::Controller
  
  cache_pages :only => :display
  
  before_filter :authorized?, :only => [:new, :edit, :create, :update, :delete]
  
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
    @page = Page.new(:url => params[:url], :user => current_user, :title => (params[:title] || params[:url]))
    @page.title = @page.title.titleize unless @page.title.blank?
  end

  # GET /pages/1/edit
  def edit
    @page = Page.get(params[:id])
  end

  # POST /pages
  def create
    @page = Page.new(params[:page])
    @page.user = current_user
    if @page.save
      redirect_to(wiki_page_url(:url => @page.url))
    else
      render(:action, "new")
    end
  end

  # PUT /pages/1
  def update
    @page = Page.get(params[:id])
    @page.user = current_user
    if @page.update_attributes(params[:page])
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
    @page = Page.first(:url => clean_url(params[:url]))
    raise Miki::PageNotFoundError.new if @page.nil?
  end

  def newest_pages
    limit = params[:limit] || 5
    @pages = Page.recent(:created_at, params[:limit])
    render(:partial, :newest_pages)
  end
  
  def recently_updated_pages
    @pages = Page.recent(:updated_at, params[:limit])
    render(:partial, :recently_updated_pages)
  end
  
  def not_found
    render(:action, :not_found, :status => 404)
  end

end
