class Page
  include DataMapper::Resource

  property :id, Serial
  property :url, String
  property :title, String, :size => 250
  property :author, String
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  
  before :save, :handle_url
  after :save, :expire_page_cache
  
  def self.recent(col = :created_at, limit = 5)
    Page.all(:order => [col.desc], :limit => (limit || 5).to_i)
  end
  
  private
  def handle_url
    self.url = clean_url(self.url)
  end
  
  def expire_page_cache
    # expire all because all pages have 'newest' and 'recently updated' sections
    Cachetastic::Caches::PageCache.expire_all
  end
end
