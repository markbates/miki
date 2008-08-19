class Page
  include DataMapper::Resource

  property :id, Serial
  property :url, String
  property :title, String
  property :author, String
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  
  before :save, :handle_url
  
  private
  def handle_url
    self.url = clean_url(self.url)
  end
end
