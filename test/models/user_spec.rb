require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe User do
  
  before(:each) do
    @user = User.first
  end

  describe("username") do
    
    # DataMapper validations aren't working correctly, so it's hard to test them.
    it "should be unique" do
      user = User.new(:username => @user.username, :password => "password", :password_confirmation => "password")
      user.should_not be_valid
      user.errors.full_messages.should include("Username is already taken")
    end
      
    it "should be present" do
      user = User.new()
      puts user.errors.full_messages
      user.should_not be_valid
      user.errors.full_messages.should include("Username must not be blank")
    end
    
    it "should not be allowed to be changed" do
      username = @user.username
      @user.update_attributes(:username => "lskajdf")
      @user.username.should_not == "lskajdf"
      @user.username.should == username
    end
    
  end
  
  describe "authenticate" do
    
    it "should take a username and password and true if it matches what's in the database" do
      User.authenticate(@user.username, "password").should_not be_nil
    end
    
    it "should take a username and password and false if it doesn't match what's in the database" do
      User.authenticate("markbates", "12356").should be_nil
    end
    
    it "should make sure the password is case insensitive" do
      user = User.create(:username => "markykang1", 
                  :password => "PasSWorD", :password_confirmation => "PasSWorD", :email => "foo@example.com", :display_name => "Marky Kang")
      User.authenticate("markykang1", "pASswORd").should_not be_nil
    end
    
  end
  
  describe "password" do
    
    describe "validations" do
  
      it "should be required on creation" do
        user = User.new(:password => "123456")
        user.should_not be_valid
        user.errors.full_messages.should include("Password does not match the confirmation")
      end
    
      it "should not be required if not updating the password" do
        user = User.first
        user.username == "markykang"
        user.should be_valid
        user.errors.should be_empty
      end
      
      it "should be hexdigested on saving" do
        user = User.first
        user.password.should == "#{user.username}password".downcase.hexdigest
      end
      
    end
    
  end

end
