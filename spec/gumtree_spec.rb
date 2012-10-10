require "vcr"
require "vcr_helper"
require_relative "../lib/gumtree"

describe Gumtree do
  it "should connect on initialization" do
    VCR.use_cassette("gumtree-login") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      @gumtree.should be_connected
    end
  end

  it "should create ads" do
    params = {
      "CatId" => "9181",
      "Title" => "Red two seater sofa and different armchair",
      "Description" => "Red two seater sofa and different armchair. Red two seater sofa and different armchair.",
      "Email" => ENV.fetch("GUMTREE_USERNAME"),
      "SubArea" => "3100240",
      "MapAddress" => "South Africa",
      "Price" => "15000",
    }
    VCR.use_cassette("gumtree-post_ad") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      gumtree_ad = @gumtree.post_ad(params)
      gumtree_ad.should be_a_kind_of(GumtreeAd)
      gumtree_ad.id.should_not be_nil
      gumtree_ad.param("Title").should == params["Title"]
    end
  end

  it "should delete ads" do
  
    VCR.use_cassette("gumtree-delete_ad") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      gumtree_ad = @gumtree.build_ad("417372267")
      gumtree_ad.delete
    end
  end
end