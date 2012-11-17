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
      "Description" => "I picked it up at a coding party on Saturday.",
      "MapAddress" => "South Africa",
      "SubArea" => SubArea::SOUTHERN_PENINSULA,
      "Neighborhood" => Neighborhood::SouthernPeninsula::MUIZENBERG,
      "Price" => "20000",
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

  it "should check if the Neighborhood is in the SubArea" do
    params = {
      "CatId" => Categories::HomeGarden::FURNITURE,
      "Title" => "Bright pink desk and office chair",
      "Description" => "I would prefer to describe it as the hottest work area ever.",
      "MapAddress" => "South Africa",
      "SubArea" => SubArea::SOUTHERN_PENINSULA,
      "Neighborhood" => Neighborhood::AtlanticSeaboard::HOUT_BAY,
      "Price" => "9000",
    }
    VCR.use_cassette("gumtree-sub_area_neighborhoods") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      expect { gumtree_ad = @gumtree.post_ad(params) }.to raise_error(RuntimeError)
    end
  end
  
  it "can return an array of ad id's" do
    VCR.use_cassette("gumtree_list_ads") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      @gumtree.list_ads.should be_a_kind_of(Array)
    end
  end

  xit "can find gumtree ads by ID and create GumtreeAd objects from them" do
    VCR.use_cassette("gumtree-build_from_id") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      current_ads = @gumtree.list_ads
      raise "No ads to run get_ad test on" unless current_ads.length >= 1
      generated_ad = @gumtree.build_from_id(current_ads[0])
      generated_ad.should be_a_kind_of(GumtreeAd)
      generated_ad.id.should_not be_nil
      generated_ad.param("Title").should_not be_nill
    end
  end

end

describe GumtreeAd do
  
  xit "should re-post ads" do
    VCR.use_cassette("gumtree_ad-repost") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      valid_ads = @gumtree.list_ads
      first_ad = valid_ads[0]
      fresh_ad = GumtreeAd.repost(first_ad)
      fresh_ad.should be_a_kind_of(GumtreeAd)
      fresh_ad.id.should_not be_nil
      fresh_ad.param("Title").should == params["Title"]
    end
  end
end