class UserFactory
  include Mack::Data::Factory
  
  field :username, :content => :username
  field :password, :immutable => true, :default => "password"
  field :password_confirmation, :immutable => true, :default => "password"
  field :email, :content => :email
  field :display_name, :content => :name
end