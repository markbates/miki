require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe PagesController do
  include Mack::ViewHelpers
  
  before(:each) do
    @page = Page.first
    @user = User.first
  end
  
  describe "index" do
    
    it "should list pages" do
      get pages_index_url
      response.should be_successful
      pages = assigns(:pages)
      pages.should == Page.all
    end
    
  end
  
  describe "show" do
    
    it "should show a page" do
      get pages_show_url(:id => @page.id)
      response.should be_redirected_to(wiki_page_url(:url => @page))
    end
    
    it "should raise a Miki::PageNotFound error if the page doesn't exist" do
      get pages_show_url(:id => 1000)
      response.should be_not_found
    end
    
  end
  
  describe "display" do
    
    it "should display a page" do
      get wiki_page_url(:url => @page)
      response.should be_successful
      response.body.should match(@page.body.strip)
      response.body.should match("<title>#{@page.title}</title>")
    end
    
    it "should raise a Miki::PageNotFound error if the page doesn't exist" do
      get wiki_page_url(:url => "foo_bar")
      response.should be_not_found
      response.body.should match("<h1>Page Not Found</h1>")
      response.body.should match("<a href=\"/pages/new\\?url=foo_bar\">foo_bar</a>\\?</h3>")
    end
    
  end
  
  describe "new" do
    
    it "should require login" do
      get pages_new_url
      response.should be_redirected_to(login_url)
      
      login
      get pages_new_url
      response.should be_successful
    end
    
    it "should pre-populate the url field if it's there" do
      login
      get pages_new_url(:url => "foo_bar")
      response.should be_successful
      response.body.should match("<input id=\"page_url\" name=\"page\\[url\\]\" size=\"50\" type=\"text\" value=\"foo_bar\" \/>")
    end
    
  end
  
  describe "edit" do
    
    it "should require a login" do
      get pages_edit_url(:id => @page.id)
      response.should be_redirected_to(login_url)
      
      login
      get pages_edit_url(:id => @page.id)
      response.should be_successful
    end
    
  end
  
  describe "create" do
    
    it "should require a login" do
      post pages_create_url, :page => {:title => "Hello World", :url => "hello_world", :body => Faker::Lorem.paragraphs.to_s}
      response.should be_redirected_to(login_url)
      
      lambda {
        login
        post pages_create_url, :page => {:title => "Hello World", :url => "hello_world", :body => Faker::Lorem.paragraphs.to_s}
        response.should be_redirected_to(wiki_page_url(:url => "hello_world"))
        page = assigns(:page)
        page.title.should == "Hello World"
      }.should change(Page, :count).by(1)
    end
    
  end
  
  describe "update" do
    
    it "should require a login" do
      put pages_update_url(:id => @page.id), :page => {:title => "Hello World"}
      response.should be_redirected_to(login_url)
    end
    
    it "should update the page" do
      login
      old_title = @page.title
      put pages_update_url(:id => @page.id), :page => {:title => "Hello World"}
      response.should be_redirected_to(wiki_page_url(:url => @page))
      @page.reload
      @page.title.should_not == old_title
      @page.title.should == "Hello World"
    end
    
  end
  
  describe "delete" do
    
    it "should require a login" do
      delete pages_delete_url(:id => @page.id)
      response.should be_redirected_to(login_url)
      
      lambda {
        login
        delete pages_delete_url(:id => @page.id)
        response.should be_redirected_to(pages_index_url)
      }.should change(Page, :count).by(-1)
    end
    
  end
  
end
