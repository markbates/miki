require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe PagesController do
  
  describe "index" do
    
    it "should list pages" do
      get pages_index_url
      response.should be_successful
    end
    
  end
  
  describe "show" do
    
    it "should show a page"
    
  end
  
  describe "new" do
    
    it "should show a form to create a new page"
    
  end
  
  describe "edit" do
    
    it "should edit a page"
    
  end
  
  describe "create" do
    
    it "should create a page"
    
  end
  
  describe "update" do
    
    it "should update a page"
    
  end
  
  describe "delete" do
    
    it "should delete a page"
    
  end
  
end
