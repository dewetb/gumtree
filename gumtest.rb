#! /usr/bin/env ruby

# I am using Rspec for the first time so this file is to do practical tests on gumtree to make sure things work after they pass the final test in rspec

require "./lib/gumtree"

gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))

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
  "Price" => "15000",
#  "PriceAlternative" => "3", #makes an item free if no price is given
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


#@gumtree = Gumtree.new("capetown-westerncape", ENV.fetch("GUMTREE_USERNAME"), ENV.fetch("GUMTREE_PASSWORD"))
gumtree_ad = gumtree.post_ad(params)
p(gumtree_ad.id)