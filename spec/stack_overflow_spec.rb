require 'spec_helper'

describe API::StackOverflow do
  before(:each) do
    API::StackOverflow.API_KEY = ENV["SO_API_KEY"]
  end

  # describe "get all users" do
  #   context "all users" do 
  #     before(:each) do
  #       @result = API::StackOverflow.get_all_users
  #     end
  #     it { @result.should_not be_nil }
  #   end

  #   context "second page" do
  #     before(:each) do
  #       @result = API::StackOverflow.get_all_users(:page => 2)
  #     end
  #     it { @result.should_not be_nil }
  #   end

  #   context "50 per page" do
  #     before(:each) do
  #       @result = API::StackOverflow.get_all_users(:pagesize => 50)
  #     end
  #     it { @result["users"].count.should == 50 }
  #   end
  # end
  
  # describe "get user" do
  #   context "60336" do
  #     before(:each) do
  #       @user = API::StackOverflow.get_user(60336)
  #     end
  #     it { @user.should_not be_nil }
  #     it { @user["display_name"].should == "JB."}
  #   end
    
  #   context "Jared314" do
  #     before(:each) do
  #       @user = API::StackOverflow.get_user("Jared314")
  #     end
  #     it { @user.should be_nil }      
  #   end
  # end
  
  # describe "get users" do
  #   before(:each) do
  #     @users = API::StackOverflow.get_users([60336, 3381])
  #   end
  #   it { @users.should_not be_nil }
  #   it { @users.select{|u| u["display_name"] == "JB"}.should_not be_nil }
  #   it { @users.select{|u| u["display_name"] == "Ben Scheirman"}.should_not be_nil }
  # end
  
  # describe "get user tags" do
  #   before(:each) do
  #     @tags = API::StackOverflow.get_user_tags(60336)
  #   end
  #   it { @tags.should_not be_nil }
  #   it { @tags["tags"].count.should > 0 }
  # end

  describe "get tags" do
    before(:each) do
      @tags = API::StackOverflow.get_tags
      @first_tag = @tags.first
    end
    it { @tags.should_not be_nil }
    it { @first_tag.name.should eq("c#") }
    it { @first_tag.has_synonyms.should be_true }
    it { @tags.count.should > 0 }
  end

  describe "get tags synonyms" do
    before(:each) do
      @tags_synonyms = API::StackOverflow.get_tags_synonyms "java"
    end
    it { @tags_synonyms.should_not be_nil }
    it { @tags_synonyms.count.should > 0 }
    it { @tags_synonyms.include?(API::StackOverflow::Tag.new("name" =>"core-java")).should be_true }
  end

  describe "get related tags" do 
    before(:each) do
      @tags_related = API::StackOverflow.get_tags_related "css"
    end
    it { @tags_related.should_not be_nil }
    it { @tags_related.count.should > 0 }
    it { @tags_related.include?(API::StackOverflow::Tag.new("name" => "html")).should be_true }
    it { @tags_related.include?(API::StackOverflow::Tag.new("name" => "tagada")).should be_false }
  end

  describe "get synonyms" do    
    before(:all) do
      @synonyms = API::StackOverflow.get_synonyms({page:1})
    end
    it { @synonyms.should_not be_nil}
    it { @synonyms.count.should > 0}
  end

end
