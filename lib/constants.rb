# A collection of Gumtree constants
# Many of these lists are still under construction and are not yet complete

module Categories
  module HomeGarden
    FURNITURE = "9181"
  end
  module Electronics
    MOBILE_PHONES = "9198"
    COMPUTERS_SOFTWARE = "9199"
  end
  module Services # When posting a service, price is not required and will not be posted if you try to pass one in.
    BUILDING_TRADES = "9063"
    PHOTOGRAPHY_VIDEO = "9115"
    ALL_SERVICES = ["9063", "9115"]
  end
end

module SubArea
  ATLANTIC_SEABOARD ='3100005'
  CAPE_FLATS ='3100261'
  CAPE_TOWN_CITY_BOWL ='3100006'
  CAPE_WINELANDS ='3100240'
  CENTRAL_KAROO ='3100243'
  EDEN_GARDEN_ROUTE ='3100241'
  HELDERBERG ='3100209'
  NORTHERN_SUBURBS ='3100007'
  OVERBERG ='3100245'
  SOUTHERN_SUBURBS ='3100008'
  SOUTHERN_PENINSULA ='3100009'
  WEST_COAST ='3100010'
end

module Neighborhood
  
  module AtlanticSeaboard # '3100005'
    CAMPS_BAY_BANTRY_BAY  = '3100017'
    DE_WATERKANT        = '3100019'
    GREEN_POINT_WATERFRONT  = '3100021'
    HOUT_BAY            = '3100022'
    SEA_POINT_THREE_ANCHOR_BAY  = '3100025'
  end

=begin
  3100261
                               
true:[['            = '3100006|
CITY_CENTRE         = '3100029'
DEVILS_PEAK         = '3100030'
GARDENS_ORANJEZICHT  = '3100031'
TAMBOERSKLOOF       = '3100034'
VREDEHOEK           = '3100035'
WOODSTOCK           = '3100274'
                               
true:[]'            = '3100240|
                               
true:[['            = '3100243|
BEAUFORT_WEST       = '3100244'
PRINCE_ALBERT       = '3100263'
                               
true:[['            = '3100241|
MOSSELBAAI          = '3100242'
GEORGE_KNYSNA       = '3100255'
PLETTENBERG_BAY     = '3100256'
                               
RUE:[['             = '3100209|
GORDONS_BAY         = '3100211'
SOMERSET_WEST       = '3100210'
STRAND              = '3100212'
                               
RUE:[['             = '3100007|
BELLVILLE           = '3100037'
BRACKENFELL         = '3100189'
DURBANVILLE         = '3100038'
GOODWOOD            = '3100190'
KRAAIFONTEIN        = '3100188'
KUILS_RIVER         = '3100191'
PAROW               = '3100204'
                               
RUE:[['             = '3100245|
SWELLENDAM          = '3100246'
HERMANUS_CALEDON    = '3100253'
CAPE_AGULHAS        = '3100254'
                               
RUE:[['             = '3100008|
CLAREMONT_NEWLANDS  = '3100041'
CONSTANTIA          = '3100042'
DIEP_RIVER          = '3100043'
KENILWORTH          = '3100044'
RONDEBOSCH_MOWBRAY  = '3100047'
TOKAI               = '3100048'
WYNBERG_PLUMSTEAD   = '3100049'
=end

  module SouthernPeninsula # '3100009'
    FISH_HOEK           = '3100051'
    MUIZENBERG          = '3100055'
    NOORDHOEK_KOMMETJIE  = '3100056'
    SCARBOROUGH         = '3100057'
    SIMONS_TOWN         = '3100058'
  end

=begin
RUE:[['             = '3100010|
BLOUBERG            = '3100061'
LANGEBAAN_SALDANHA  = '3100062'
MELKBOSSTRAND       = '3100063'
MILNERTON           = '3100064'
TABLE_VIEW_PARKLANDS  = '3100065'
VANRHYNSDORP_NORTH  = '3100208'
=end
end

SUB_AREA_NEIGHBORHOODS = {
'3100005' => ['3100017','3100019','3100021','3100022','3100025',], #AtlanticSeaboard
#'3100261' => []
#'3100006' => [['3100029','City Centre',[]],['3100030','Devils Peak',[]],['3100031','Gardens & Oranjezicht',[]],['3100034','Tamboerskloof',[]],['3100035','Vredehoek',[]],['3100274','Woodstock',[]]],
#'3100240' => []
#'3100243' => [['3100244','Beaufort West',[]],['3100263','Prince Albert',[]]],
#'3100241' => [['3100242','Mosselbaai',[]],['3100255','George & Knysna',[]],['3100256','Plettenberg Bay',[]]],
#'3100209' => [['3100211','Gordon\'s Bay',[]],['3100210','Somerset West',[]],['3100212','Strand',[]]],
#'3100007' => [['3100037','Bellville',[]],['3100189','Brackenfell',[]],['3100038','Durbanville',[]],['3100190','Goodwood',[]],['3100188','Kraaifontein',[]],['3100191','Kuils River',[]],['3100204','Parow',[]]],
#'3100245' => [['3100246','Swellendam',[]],['3100253','Hermanus & Caledon',[]],['3100254','Cape Agulhas',[]]],
#'3100008' => [['3100041','Claremont & Newlands',[]],['3100042','Constantia',[]],['3100043','Diep River',[]],['3100044','Kenilworth',[]],['3100047','Rondebosch & Mowbray',[]],['3100048','Tokai',[]],['3100049','Wynberg & Plumstead',[]]],
'3100009' => ['3100051','3100055','3100056','3100057','3100058'], #SouthernPeninsula
#'3100010' => [['3100061','Blouberg',[]],['3100062','Langebaan & Saldanha',[]],['3100063','Melkbosstrand',[]],['3100064','Milnerton',[]],['3100065','Table View & Parklands',[]],['3100208','Vanrhynsdorp - North',[]]]
}