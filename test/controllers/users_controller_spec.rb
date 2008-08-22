require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe UsersController do
  
  describe "index" do
    
    it "should list users"
    
  end
  
  describe "show" do
    
    it "should show a user"
    
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
    
    it "should edit a user"
    
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
    
    it "should update a user"
    
  end
  
  describe "delete" do
    
    it "should delete a user"
    
  end
  
end
