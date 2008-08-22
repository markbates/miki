class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String, :size => 20
  property :password, String
  property :email, String, :size => 200
  property :display_name, String, :size => 250
  property :created_at, DateTime
  property :updated_at, DateTime
  
  has n, :pages
  
  attr_accessor :password_confirmation
  
  validates_is_unique :username
  validates_is_confirmed :password
  validates_present :username
  
  before(:save, :digest_password)
  before(:save, :check_username_for_updates)
  
  def self.authenticate(username, password)
    User.first(:username => username, :password => "#{username}#{password}".downcase.hexdigest)
  end
  
  private
  # make sure no one can change their username.
  def check_username_for_updates
    if attribute_dirty?(:username) && !new_record?
      self.username = original_values[:username]
    end
  end
  
  def digest_password
    if attribute_dirty?(:password)
      self.password = "#{self.username}#{self.password}".downcase.hexdigest
    end
  end
end
