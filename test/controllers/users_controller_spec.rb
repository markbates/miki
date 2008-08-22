require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe UsersController do
  
  before(:each) do
    @user = User.first
  end
  
  describe "index" do
    
    it "should list users" do
      get users_index_url
      response.should be_successful
      assigns(:users).should == User.all
    end
    
  end
  
  describe "show" do
    
    it "should show a user" do
      get users_show_url(:id => @user)
      response.should be_successful
      assigns(:user).should == @user
    end
    
  end
  
  describe "new" do
    
    it "should not allow you to register" do
      get users_new_url
      response.should be_successful
      response.body.should match('<h1>We\'re Sorry...</h1>')
      response.body.should match('<h3>MackWiki.com is currently not allowing user registrations. Please try back at another time. Thank you.</h3>')
    end
    
  end
  
  describe "edit" do
    
    it "should require login" do
      get users_edit_url(:id => @user)
      response.should be_redirected_to(login_url)
    end
    
    it "should require the owner to edit it" do
      session[:user_id] = @user.id
      get users_edit_url(:id => @user)
      response.should be_successful
      assigns(:user).should == @user
      
      get users_edit_url(:id => User.first(:id.not => @user.id))
      response.should be_redirected_to(login_url)
    end
    
  end
  
  describe "create" do
    
    it "should not allow you to register" do
      post users_create_url
      response.should be_successful
      response.body.should match('<h1>We\'re Sorry...</h1>')
      response.body.should match('<h3>MackWiki.com is currently not allowing user registrations. Please try back at another time. Thank you.</h3>')
    end
    
  end
  
  describe "update" do
    
    it "should require login" do
      put users_update_url(:id => @user)
      response.should be_redirected_to(login_url)
    end
    
    it "should require the owner to edit it" do
      session[:user_id] = @user.id
      put users_update_url(:id => @user), :user => {:display_name => "Mark Bates"}
      response.should be_redirected_to(users_show_url(:id => @user))
      assigns(:user).should == @user
      assigns(:user).display_name.should == "Mark Bates"
      
      put users_update_url(:id => User.first(:id.not => @user.id))
      response.should be_redirected_to(login_url)
    end
    
  end
  
  describe "delete" do
    
    it "should delete a user"
    
  end
  
end
