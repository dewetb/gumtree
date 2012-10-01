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
      "PreviewAd" => "",
      "ChangeCategory" => "",
      "ShowTerms" => "",
      "ChangePhoto" => "",
      "AdId" => "",
      "Guid" => "",
      "SurveyResponse" => "",
      "CatId" => "9181",
      "extraInfo" => "",
      "useBasicUpload" => "false",
      "RequestRefererUrl" => "%252C%2C%252C",
      "ReformattedDesc" => "0",
      "AdType" => "1",
      "PriceAlternative" => "3",
      "A_ForSaleBy" => "ownr",
      "Title" => "Red two seater sofa and different armchair",
      "Description" => "Red two seater sofa and different armchair. Red two seater sofa and different armchair.",
      "Photo" => "",
      "Email" => ENV.fetch("GUMTREE_USERNAME"),
      "Phone" => "",
      "SubArea" => "3100240",
      "MapAddress" => "South Africa",
      "AddressStreet" => "",
      "AddressCity" => "",
      "AddressRegion" => "",
      "AddressZip" => "",
      "AddressConfidenceLevel" => "0",
      "AddressLatitude" => "",
      "AddressLongitude" => "",
      "AddressCounty" => "",
      "AddressSelectedByUser" => "false",
      "featuredAdDuration" => "0",
      "text_loading" => "Loading...",
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
    it "should navigate to the ad page"do
    end
  
    VCR.use_cassette("gumtree-delete_ad") do
      @gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
      gumtree_ad = @gumtree.build_ad("417372267")
      gumtree_ad.delete
    end
  end
end