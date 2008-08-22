class PageFactory
  include Mack::Data::Factory
  
  field :url,     "some_url", :content => :alpha, :max_length => 50
  field :title,   "", :content => :alpha, :max_length => 250, :min_length => 10
  field :author,  "", :content => :name
  field :body,    "", :content => :alpha, :max_length => 10000
end