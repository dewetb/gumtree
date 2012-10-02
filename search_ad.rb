#! /usr/bin/env ruby
=begin
http://capetown-westerncape.gumtree.co.za/f-SearchAdRedirect?isSearchForm=true&Keyword=418852190&CatId=0&Location=3100001
=end
base_url = "http://capetown-westerncape.gumtree.co.za"

ad_id = 418852190

url = "#{base_url}/f-SearchAdRedirect?isSearchForm=true&Keyword=#{ad_id}"

delete_url = "#{base_url}/c-MyAds?Action=DELETE_ADS&Mode=ACTIVE&RowId=#{ad_id}&SurveyResponse=4

Request URL:http://capetown-westerncape.gumtree.co.za/c-ViewAd
Request Method:POST
Status Code:302 Moved Temporarily

AdId:418877773
SurveyResponse:4
Action:delete

Location:http://capetown-westerncape.gumtree.co.za/c-MyAds?Action=DELETE_ADS&Mode=ACTIVE&RowId=418881862&SurveyResponse=4
         http://capetown-westerncape.gumtree.co.za/c-ManageMyAds?RowId=418886320&Action=DELETE_ADS&Mode=ACTIVE&SurveyResponse=4