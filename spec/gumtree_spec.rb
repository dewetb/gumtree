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
      "CatId" => Categories::HomeGarden::FURNITURE,
      "Title" => "Red two seater sofa and different armchair",
      "Description" => "I would prefer to describe it as a red two seater sofa and different armchair.",
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

  it "should raise an exception when an ad is not complete" do
    params = {
      "Title" => "Red two seater sofa and different armchair",
    }
    VCR.use_cassette("gumtree-ad_complete?") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      expect { gumtree_ad = @gumtree.post_ad(params) }.to raise_error(RuntimeError)
    end
  end
  
  it "should evaluate completeness of ads based on category" do
    params = {
      "CatId" => Categories::Services::PHOTOGRAPHY_VIDEO,
      "Title" => "Awesome photography",
      "Description" => "I would prefer to describe it as the best photography ever!",
      "MapAddress" => "South Africa",
    }
    VCR.use_cassette("gumtree-post_ad_services") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      gumtree_ad = @gumtree.post_ad(params)
      gumtree_ad.should be_a_kind_of(GumtreeAd)
      gumtree_ad.id.should_not be_nil
      gumtree_ad.param("Title").should == params["Title"]
    end
  end
end