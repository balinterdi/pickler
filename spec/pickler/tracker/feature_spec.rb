require File.join(File.dirname(File.dirname(File.dirname(__FILE__))),'spec_helper')

describe Pickler::Feature do
  before do
    @feature = Pickler::Feature.new(nil, 1)
  end
  describe "#pushable?" do
    it "returns true when the first line is a zero-length comment" do
      @feature.stub!(:id).and_return(nil)
      @feature.stub!(:local_body).and_return("#  \nFeature:")
      @feature.should be_pushable
    end
    
    it "returns true when the first line is an empty comment" do
      @feature.stub!(:id).and_return(nil)
      @feature.stub!(:local_body).and_return("#  \nFeature:")
      @feature.should be_pushable
    end

    it "returns true when the first line is an empty comment and the second is cucumber tags" do
      @feature.stub!(:id).and_return(nil)
      @feature.stub!(:local_body).and_return("#  \n@wip @users\nFeature:")
      @feature.should be_pushable
    end

    it "returns true when the first line is the URL for a new feature" do
      @feature.stub!(:id).and_return(nil)
      @feature.stub!(:local_body).and_return("@http://www\.pivotaltracker\.com/story/new\nFeature:")
      @feature.should be_pushable
    end

    it "returns false when the first line is not an empty comment or a URL for a new feature" do
      @feature.stub!(:id).and_return(nil)
      @feature.stub!(:local_body).and_return("# TODO: make this line empty\nFeature:")
      @feature.should_not be_pushable
    end

    it "returns false when the second line contains a comment, too" do
      @feature.stub!(:id).and_return(nil)
      @feature.stub!(:local_body).and_return("# \n#TODO: remove this\nFeature:")
      @feature.should_not be_pushable
    end

  end
end