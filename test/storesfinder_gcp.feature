@baseUrl @baseUrl-mobileutility_gcp
Feature: Stores finder examples
  The following are test scenarios againts the stores finder service

  #------------------------
  # STORES FINDER
  #------------------------

  Scenario: latitude=0,longitude=0
    When I make a GET request to "/stores?longitude=0&latitude=0&channelid=1"
    Then The response status code should be "200"
    And The response number of stores should be 20

  Scenario: Store closest to Lotto NZ Office
    When I make a GET request to "/stores?longitude=174.779520&latitude=-36.872087&channelid=1&maxcount=1"
    Then The response status code should be "200"
    And The closest store is "Countdown Newmarket"

  Scenario Outline: Store closest to Lotto NZ Office
    Given longitude set to <longitude>
    And latitude set to <latitude>
    When I fetch store locations
    Then The response status code should be "200"
    And The closest store is "Countdown Newmarket"

    Examples:
      | longitude  | latitude   |
      | 174.779520 | -36.872087 |

  Scenario Outline: Stores within 1km from Lotto NZ Office
    Given longitude set to <longitude>
    And latitude set to <latitude>
    And radius set to <radius>
    When I fetch store locations
    Then The response status code should be "200"
    And There are <count> stores within <radius> km of the given location

    Examples:
      | longitude  | latitude   | radius | count |
      | 174.779520 | -36.872087 |    1   |   4   |

  Scenario Outline: Find closest store
    Given longitude set to <longitude>
    And latitude set to <latitude>
    When I fetch store locations
    Then The response status code should be "200"
    And The closest store is "<store>"

    Examples:
      |longitude|latitude|store|
      |173.1534417|-35.17096753|Ahipara Superette|
      |172.9671681|-43.80493293|Akaroa Four Square|
      |174.6424309|-36.64838376|Dairy Flat Food Mart & Liquor|
      |169.3860848|-45.24942747|Alexandra New World|
      |169.3885118|-45.25162821|Paper Plus Alexandra|
      |172.731278|-43.156545|Countdown Amberley|
      |172.72992|-43.15436638|Gallaughers Supermarket of Amberley|
      |168.8324966|-44.93847454|Arrowtown Night 'n Day|
      |171.744846|-43.90520607|Ashburton New World|
      |171.751653|-43.901963|Countdown Ashburton|
      |171.7461486|-43.90551467|Paper Plus Ashburton|
      |171.7424489|-43.88719798|Allenton Foodmarket|
      |171.5686855|-44.00317152|Hinds Convenience & Lotto|
      |171.7632091|-43.9031251|Netherby Four Square|
      |171.720475|-43.92005931|Tinwald Supervalue|
      |174.6972817|-36.72597413|Albany Central Superette|
      |174.6932718|-36.74444958|Albany Highway Superette|
      |174.7069738|-36.73039614|Albany Pak N Save|
      |174.695961|-36.742826|Albany Superette|
      |174.7109091|-36.74153815|Amits Superette|
      |174.715580|-36.752106|Caltex Upper Harbour|
      |174.6890695|-36.72412657|Green & Grocery World|
      |174.7023055|-36.75656015|Highway Convenience Store|
      |174.7099752|-36.72960735|New World Albany|
      |174.7224012|-36.71276492|Seville Superette|
      |174.706006|-36.732507|Whitcoulls Albany Mall|
      |174.698291|-36.725676|Z Albany|
      |174.788508|-37.001136|Z Skyway|
      |174.7697328|-36.84570181|City Convenience Store|
      |174.764583|-36.848691|Countdown Metro|
      |174.7669763|-36.84584385|Fix Fort Street|
      |174.7738249|-36.84539841|Foto Fast Digital Imaging & Lotto|
      |174.7648202|-36.84994935|Mid City Lotto & Newsagent|
      |174.7529954|-36.85927801|Mobil Karangahape Road|
      |174.765737|-36.846552|New World Metro|
      |174.7580506|-36.85761362|Newton Pharmacy|
      |174.7626085|-36.84340838|Om's Grocery Mart|
      |174.7623329|-36.85642394|Smile Mart|
      |174.757227|-36.845174|Smile Supermarket Viaduct|
      |174.780018|-36.847373|Snackers Convenience|
      |174.7631163|-36.84821986|Victoria Street Lotto & Newsagency|
      |174.756953|-36.858138|Walia Superette K Road|
      |174.684233|-36.885867|Avondale Foodmarket|
      |174.684457|-36.887428|Avondale Superette|
      |174.70183|-36.90622601|Mobil Blockhouse Bay|
      |174.6970701|-36.89966199|Neelam Superette|
      |174.7005171|-36.89077909|Roberts Superette & Lotto|
      |174.697077|-36.897587|Supervalue Avondale|
      |174.738843|-36.88533|Caltex Balmoral|
      |174.746542|-36.890381|Kensington Dairy|
      |174.6875464|-36.79213568|Beach Haven Dairy & Lotto|
      |174.6951014|-36.78939566|Lancaster Four Square|
      |174.691149|-36.799127|Rangatira Superette|
      |174.9969221|-36.88254561|Beachlands Post & Lotto|
      |174.7896479|-36.80763958|Belmont Superette and Lotto|
      |174.7007573|-36.7983672|Don's Food Market|
      |174.701106|-36.79238|Merivale Superette|
      |174.706919|-36.794162|Salisbury Superette|
      |174.704497|-36.805939|Verrans Corner Superette|
      |174.7260053|-36.81137598|Birkenhead Superette & Lotto|
      |174.7253511|-36.81210759|Highpoint Temptations Lotto|
      |174.7261486|-36.81217582|Jacob's Photo & Digital|
      |174.710939|-36.811008|New World Birkenhead|
      |174.7015263|-36.92279881|United Video Blockhouse Bay|
      |174.9108842|-36.93103905|Z Botany|
      |174.9175022|-36.909773|Mirrabooka Superette|
      |174.912934|-36.93120095|New World Botany|
      |174.9141139|-36.93059204|Whitcoulls Botany Downs|
      |174.748209|-36.715346|Berrymans|
      |174.7491139|-36.71682271|Countdown Browns Bay|
      |174.747175|-36.716518|New World Browns Bay|
      |174.7428139|-36.71575028|Phoenix Dairy|
      |174.728317|-36.709982|Z Northcross|
      |174.9116495|-36.87976075|Bucklands Beach Superette|
      |174.903746|-36.868044|Centre Superette|
      |174.9085719|-36.89846399|Countdown Highland Park|
      |174.8677203|-37.03275867|Clendon New World|
      |174.868197|-37.031083|Clendon Foodmarket|
      |174.8598317|-37.03090935|Finlayson Superette|
      |174.8699373|-37.03341164|Clendon Postshop Lotto|
      |175.037326|-36.9927487|Clevedon Superette|
      |174.8952026|-36.9766471|Dawson Superette|
      |174.8896732|-36.98599442|Diorella Superette|
      |174.893447|-36.978783|Othello Superette|
      |174.9391849|-36.90409019|Cockle Bay Four Square|
      |174.932139|-36.8944034|Paper Plus Howick|
      |174.792803|-36.829144|Calliope Superette|
      |174.7963207|-36.82951608|Devonport New World|
      |174.797172|-36.831121|Haywards Paper Power|
      |174.8725464|-36.93767619|Z Highbrook|
      |174.9115471|-36.92917407|Countdown Botany|
      |174.876393|-36.937271|Smile Supermarket-Highbrook|
      |174.896698|-36.929745|Z Harris Rd|
      |174.761025|-36.86436411|Symonds Lotto|
      |174.802793|-36.897604|AJ's Smile Supermarket|
      |174.8105965|-36.8983441|Cardz Mags n Lotto Ellerslie|
      |174.8097623|-36.89787572|Ellerslie Four Square|
      |174.822029|-36.891177|Kornaway Dairy|
      |174.775016|-36.890233|Caltex Epsom|
      |174.7732846|-36.90017467|Greenwoods Paper Power|
      |174.8872384|-36.89557402|Farmcove Superette|
      |174.79906|-36.952778|Concorde Superette|
      |174.8037534|-36.95706244|Ponderosa Superette|
      |174.901924|-36.961858|Botany Garden & Orchard|
      |174.9019492|-36.96469418|Botany Junction Four Square|
      |174.9028623|-36.98098818|Chapel Park Superette & Lotto|
      |174.9057863|-36.96681603|Kwik-E-Mart|
      |174.913519|-36.964579|Pak N Save Ormiston|
      |174.9110547|-36.94941136|Willowbank Superette|
      |174.905471|-36.964951|Xpress Mart|
      |174.897037|-36.946944|Flatbush Supervalue|
      |174.7466936|-36.76805712|Raines Avenue Foodmarket|
      |174.7509642|-36.84840125|Victoria Park New World|
      |174.646643|-36.908310|Caltex West Coast Road|
      |174.664057|-36.908415|Countdown Kelston|
      |174.6397574|-36.92143083|Eden Superette & Lotto|
      |174.654067|-36.91114119|Fresh Choice Glen Eden|
      |174.6513383|-36.91096003|Glen Eden Four Square|
      |174.6639504|-36.9082405|Kelston Digital Photos|
      |174.6596124|-36.90468789|Kwiki Mart Kelston|
      |174.651627|-36.910350|New Zeal Superette|
      |174.628707|-36.908410|Pop Inn Dairy|
      |174.8705384|-36.87669419|Fenchurch Superette|
      |174.8554424|-36.87822834|Glen Innes Dairy And Lotto Outlet|
      |174.8541052|-36.87562852|Pak N Save Glen Innes|
      |174.856512|-36.878383|Supa Value Supermarket-Line Rd|
      |174.874558|-36.869502|West Tamaki Superette|
      |174.6444255|-36.88688469|Glendene Superette|
      |174.6534481|-36.89277848|Hepburn Superette|
      |174.657354|-36.884015|Sai Superette|
      |174.8594749|-36.86915024|Ashby Superette|
      |174.7318462|-36.78369263|Chartwell Food Centre & Lotto|
      |174.729046|-36.779349|Chivalry Foodmart|
      |174.7215872|-36.78074003|Civic Video Glenfield|
      |174.7250514|-36.79181424|Coronation Superette|
      |174.739939|-36.783604|Fresh n Save|
      |174.7230852|-36.78315065|Magazine City & Lotto|
      |174.720756|-36.7745|Manuka Dairy|
      |174.7446074|-36.77828159|Pak n Save Wairau Road|
      |174.7221092|-36.7702432|Pam's Corner Dairy|
      |174.730113|-36.770411|View Road Dairy|
      |174.721584|-36.782462|Whitcoulls Glenfield|
      |174.724203|-36.794307|Z Glen Park|
      |174.8946296|-36.99827244|Everglade Four Square|
      |174.7701683|-36.86100608|Auckland Hospital Book & Post Shop|
      |174.768631|-36.861074|Grafton Convenience|
      |174.679199|-36.93074077|New World Green Bay|
      |174.6776626|-36.93120112|Z Green Bay|
      |174.6702474|-36.77579139|Greenhithe Store|
      |174.793031|-36.88957159|Countdown Greenlane|
      |174.7959582|-36.88998129|Z Greenlane|
      |174.747049|-36.864084|Arch Hill Superette|
      |174.7318878|-36.85436081|Countdown Grey Lynn|
      |174.7375793|-36.86556388|Grey Lynn Stationers|
      |174.7308316|-36.85894306|Neal's Superette|
      |174.8997|-36.881288|Fresh Choice Half Moon Bay|
      |174.899066|-36.899771|Video Ezy Pakuranga|
      |174.6266843|-36.89658834|Ash's Superette|
      |174.628098|-36.886085|Baba Superette|
      |174.630311|-36.854576|Caltex Lincoln Road|
      |174.633102|-36.879669|Convenience @ 357|
      |174.632212|-36.880215|Countdown Henderson|
      |174.6305616|-36.857134|Countdown Lincoln Road|
      |174.6143913|-36.86361514|Fair Price Four Square|
      |174.6311618|-36.8782576|Henderson Pak N Save|
      |174.6280892|-36.86937441|Hospital Dairy|
      |174.6297166|-36.85513447|Lincoln Road Dairy|
      |174.6328942|-36.8816578|Meg Star|
      |174.6295342|-36.85793221|Pak N Save Lincoln Road|
      |174.6154002|-36.88257195|Palomino Supervalue|
      |174.6215293|-36.86208837|Rathgar Road Discount Foodmart|
      |174.6137079|-36.89724739|Valley Road Superette|
      |174.6331016|-36.88057114|West City Lotto|
      |174.6216471|-36.8917185|Z Henderson Valley|
      |174.7365119|-36.84552068|Ardmore Dairy|
      |174.734982|-36.8456|Jervois Food Market|
      |174.9071464|-36.89804754|Paper Plus Highland Park|
      |174.7467508|-36.79130039|Sunnybrae Superette|
      |174.738215|-36.930482|Waikowhai Superette|
      |174.646692|-36.798011|Countdown Hobsonville|
      |174.6489333|-36.79835585|Hobsonville Four Square|
      |174.919212|-36.899487|Botany Road Superette|
      |174.9296713|-36.89503888|Countdown Howick|
      |174.9271055|-36.91366492|Meadowlands Lotto|
      |174.925091|-36.903773|New World Howick|
      |174.9177969|-36.91902187|Sunny Dairy Superette|
      |174.925495|-36.902531|Vincent Street Superette|
      |174.5444249|-36.77235311|Highway Supermart|
      |174.7367859|-36.87392882|Navya Superette|
      |174.748269|-36.8707972|Night n Day @ Gull Kingsland|
      |174.8438846|-36.85320913|Melanesia Foodhall|
      |174.7534592|-36.73897778|Mairangi Bay Dairy & Lotto|
      |174.7291838|-36.74958356|Mobil Constellation Drive|
      |174.7856603|-36.96882926|Airport Oaks Pharmacy|
      |174.7970044|-36.97596244|Central Dairy|
      |174.7874461|-36.99725391|Countdown Airport|
      |174.810851|-36.948727|Favona Foodmarket|
      |174.809224|-36.953748|Gadsby Supermarket|
      |174.7986961|-36.96884948|Mangere Stationery & Post|
      |174.7973831|-36.96996779|Orly Ave Superette|
      |174.7980992|-36.96835769|Pak N Save Mangere|
      |174.7909311|-37.01019824|Relay Auckland Domestic|
      |174.7780443|-37.01000665|Relay Auckland Int'l Ground|
      |174.782889|-37.005757|Relay Auckland Int'l Level 1|
      |174.8361756|-36.96364399|Rosella Superette|
      |174.7869477|-36.94274232|Fresh Choice Mangere Bridge|
      |174.7852978|-36.95454498|Mountain Road Pricecutter|
      |174.7776777|-36.94428606|Wallace Rd Superette|
      |174.813127|-36.968813|Ashley Ave Superette|
      |174.8334227|-36.95771405|Caltex Mangere|
      |174.824193|-36.965759|Countdown Mangere East|
      |174.834102|-36.972543|Graeme Ave Superette|
      |174.8277569|-36.97404498|Kingsford Supermarket|
      |174.8249854|-36.96663956|Mangere East Post & More|
      |174.806903|-36.963244|McKinstry Superette|
      |174.824284|-36.958331|Vine Street Supa Discounter|
      |174.8145868|-36.96275684|Wickman Way Price-Cutter|
      |174.8822756|-36.9874266|Countdown Manukau|
      |174.8843074|-36.99198042|Countdown Manukau City Mall|
      |174.8842248|-36.99174891|Grab n Go|
      |174.8813272|-36.98697565|Manukau Pak 'N Save|
      |174.9038908|-37.02157176|Alfriston Dairy|
      |174.9008074|-37.02552715|Bellbird Dairy & Lotto|
      |174.897058|-37.030243|Boomerang Superette|
      |174.864504|-37.02109|Burbank Four Square|
      |174.864668|-37.017465|Countdown Manurewa|
      |174.89235|-37.013637|Grand Vue Dairy|
      |174.9004092|-37.0133305|Hillpark Superette & Lotto|
      |174.8876045|-37.0275498|Leabank Superette|
      |174.911587|-37.01262859|Mobil The Gardens|
      |174.8973642|-37.02258733|New World Southmall|
      |174.8746517|-37.01493912|Palm Superette|
      |174.8630586|-37.01853971|Roscommon Superette|
      |174.8728964|-37.02191915|Rowandale Superette|
      |174.8975209|-37.02270816|Southmall Lotto Kiosk|
      |174.886382|-37.022737|Sunnybrae Dairy & Lotto - Manukau|
      |174.8954859|-37.02083451|The Cutting Bar & Lotto Shop|
      |174.899673|-37.023663|Z Manurewa|
      |175.0342725|-36.88035084|Omana View Superette|
      |174.6107745|-36.82198949|Countdown Westgate|
      |174.6213781|-36.84717293|Lincoln Heights Superette|
      |174.6112887|-36.86001163|Lower Don Buck Dairy|
      |174.603201|-36.83445796|Massey Amcal Pharmacy|
      |174.6221316|-36.83321506|Royal Heights Dairy & Lotto|
      |174.610581|-36.818952|Countdown North West|
      |174.6100404|-36.82174957|Westgate Pharmacy|
      |174.6086999|-36.82130081|Z Massey North|
      |174.7541366|-36.78099309|Lakeview Superette|
      |174.764711|-36.772574|Milford Paper Power|
      |174.764751|-36.772446|New World Milford|
      |174.758327|-36.768495|Pacific Superette|
      |174.7669455|-36.77158149|Sweet Lotto Centre|
      |174.8363076|-36.86020566|Kepa Road Superette|
      |174.7267321|-36.89409546|Mobil Mt Albert|
      |174.7515525|-36.91634076|Crown Superette|
      |174.8418732|-36.9247643|Z Sylvia Park|
      |174.714922|-36.884932|Mt Albert Superette|
      |174.7066643|-36.89274008|Pak N Save Mt Albert|
      |174.7258637|-36.880191|Rocket Superette|
      |174.733598|-36.882982|Whitcoulls St Lukes|
      |174.7105321|-36.88386663|Woodward Dairy|
      |174.7512418|-36.87590017|Countdown Mt Eden|
      |174.7487344|-36.88241116|Dominion Superette|
      |174.762238|-36.881923|Eden Foods (Mt Eden)|
      |174.7610628|-36.87110763|Esplanade Foodmarket|
      |174.7580012|-36.89530293|Manisha Superette|
      |174.7418784|-36.90350177|Amigo's Dairy, Stationery & Lotto|
      |174.7239447|-36.92558428|Countdown Lynfield|
      |174.727399|-36.904407|Countdown Mt Roskill|
      |174.736453|-36.926125|Glass Road Superette|
      |174.737674|-36.901717|Jyotis Dairy|
      |174.7211315|-36.90051164|Lockingtons Pharmacy Ltd|
      |174.730542|-36.915835|Mayfair Superette|
      |174.743227|-36.924094|McKinnon Street Superette|
      |174.7349993|-36.90867249|New World Mt Roskill|
      |174.742861|-36.900294|Tai Ping (Mt Roskill)|
      |174.837067|-36.902415|Barrack Road Superette|
      |174.8394749|-36.91677466|Countdown Sylvia Park|
      |174.8382786|-36.90801189|Drop In Superette & Lotto|
      |174.8428612|-36.93066714|Fresh For Less|
      |174.8323711|-36.89676739|Harris Road Superette & Lotto|
      |174.841641|-36.904252|Highway Dairy|
      |174.8326991|-36.88985248|New World Stonefields|
      |174.8393957|-36.91663106|Pak N Save Sylvia Park|
      |174.8297659|-36.90429829|Panorama Dairy|
      |174.8394439|-36.91671051|Paper Plus Sylvia Park|
      |174.687800|-36.910354|Caltex Clark Street|
      |174.6848929|-36.90639771|Countdown Lynn Mall|
      |174.669582|-36.909698|Ezy Mart Dairy|
      |174.6853696|-36.91058468|New World New Lynn|
      |174.683681|-36.908944|Station Mart|
      |174.6848929|-36.90639771|Whitcoulls New Lynn|
      |174.6812538|-36.90282372|Z New Lynn|
      |174.7135817|-36.90742605|New Windsor Dairy|
      |174.7770942|-36.87062686|Countdown Newmarket|
      |174.777045|-36.870302|Paper Plus Newmarket|
      |174.776643|-36.865530|Skyblue Superette|
      |174.7775945|-36.86906366|Unichem on Broadway|
      |174.734379|-36.801655|City View Superette|
      |174.7444102|-36.80157743|Mitchell's Paper Power|
      |174.7378103|-36.81003635|Z Northcote|
      |174.7279509|-36.70950635|Northcross Pricecutter & Lotto|
      |174.9142026|-36.92929753|Pak n Save Botany|
      |174.792445|-36.906680|Logan Park Foodmarket|
      |174.778688|-36.916574|Jellicoe Park Dairy|
      |174.8009628|-36.91515348|Mt Smart Superette|
      |174.785036|-36.92147718|Onehunga Mall Superette|
      |174.7854966|-36.92374864|Onehunga Office Supplies|
      |174.7918197|-36.91531946|Smart Superette|
      |174.8284663|-36.86060072|Eastridge Lotto|
      |174.8244527|-36.86093812|Orakei Mini Mart|
      |174.814682|-36.85599867|Orakei Post Centre Superette|
      |174.6187365|-36.91301841|Oratia Superette|
      |174.845652|-36.948711|Caltex Monument|
      |174.844321|-36.94486509|Crystal Mini Mart and Lotto|
      |174.8411723|-36.94183675|Downtown Dairy|
      |174.8513187|-36.93903967|Motorway Dairy & Lotto|
      |174.845056|-36.942617|Sai Super Store|
      |174.8427451|-36.94496847|Supervalue Hall Avenue|
      |174.8428705|-36.94106619|Z Otahuhu|
      |174.865583|-36.960381|Ashton Dairy|
      |174.8871612|-36.96118996|Buffy's Superette|
      |174.885803|-36.96855945|Ferguson Dairy|
      |174.8830523|-36.97560662|Flatbush Superette|
      |174.8694381|-36.95309725|Gilbert Road Superette|
      |174.87845|-36.968262|Kingston Food Centre|
      |174.886574|-36.953345|Mayfield Superette|
      |174.873213|-36.961107|Otara Post|
      |174.8594795|-36.95755302|Wymondley Superette|
      |174.900536|-36.91167|Cascade Superette|
      |174.8700336|-36.91306473|Lucky Shop Lotto|
      |174.889625|-36.915237|Pakuranga Heights Four Square|
      |174.8725471|-36.91261549|Pakuranga Lotto|
      |174.8767845|-36.92047731|Ti Rakau Superette|
      |174.899415|-36.900064|Z Pakuranga|
      |174.8877628|-36.92070552|Gossamer Minimart & Lotto Shop|
      |174.8517657|-36.89812988|Jellicoe Court Bookstore|
      |174.8569259|-36.900718|London Superette|
      |174.854684|-36.899479|Supavalue Supermarket Panmure|
      |174.8632554|-36.89290966|Tripoli Road Super 7|
      |174.947512|-37.062112|Eastpark Superette|
      |174.935658|-37.049226|Porchester Road Superette|
      |174.948302|-36.929745|Z Kingsway|
      |174.920056|-37.043456|Z Takanini|
      |174.860030|-36.970837|Countdown Papatoetoe|
      |174.854869|-36.962546|Grange Superette|
      |174.84883|-36.99164242|Hari Superette|
      |174.8536026|-36.97958699|New World Papatoetoe|
      |174.8615664|-36.97073399|Papatoetoe Plaza Lotto|
      |174.861446|-36.969417|Rockyz Mini Mart|
      |174.8541034|-36.97965465|Schofields Stationers Paper Power|
      |174.87671|-36.980585|Sing Lee Supermarket|
      |174.854720|-36.957518|Vege Oasis|
      |174.867965|-36.982984|Victoria Dairy|
      |174.863005|-36.96673341|Z Hunters Corner|
      |174.7827274|-36.85900022|Hilltop Superette|
      |174.7791804|-36.85312028|Wyvern Dairy|
      |174.774848|-36.849679|Z Beach Road|
      |174.808713|-36.90358|Caltex Penrose|
      |174.8048504|-36.90736229|Rockfield Superette|
      |174.724696|-36.730422|Night n Day @ Gull Greville Road|
      |174.7127175|-36.8691484|Z Point Chev|
      |174.749348|-36.859240|Countdown Ponsonby|
      |174.743918|-36.847903|Paper Plus Ponsonby|
      |174.7391404|-36.85503236|Richmond Road Superette|
      |174.7048075|-36.86341387|PK Superette|
      |174.7108418|-36.87025817|Pt Chevalier Lotto Plus|
      |174.8646816|-36.88251911|Riverside Dairy|
      |174.908371|-37.200022|Z Pukekohe|
      |174.600462|-36.864081|Fresh Choice Ranui|
      |174.7964262|-36.88073603|Mainly Mags|
      |174.7994629|-36.87108617|Victoria Ave Superette & Lotto|
      |174.8114058|-36.88086477|Village Dairy|
      |174.735306|-36.747224|Caltex Constellation|
      |174.731928|-36.748196|Z Constellation Drive|
      |174.747265|-36.726470|Rothesay Bay Superette|
      |174.7757055|-36.91011208|Royal Oak Mall Lotto|
      |174.773621|-36.911182|Z Royal Oak|
      |174.7406156|-36.87784095|Rockys Superette|
      |174.7362444|-36.89132682|Smart Deal Bazaar|
      |174.8577792|-36.85107604|Eden Foods (St Heliers)|
      |174.8609884|-36.85929997|Maskell Lotto & Convenience Store|
      |174.851413|-36.879995|Countdown St Johns|
      |174.8323015|-36.8725951|Dorchester Superette|
      |174.8271855|-36.87585484|Paper Plus Meadowbank|
      |174.844164|-36.875060|Simkin Superette|
      |174.733598|-36.882984|Lotto NZ Concept Store|
      |174.844828|-36.886785|Supervalue Stonefields|
      |174.891585|-36.901118|Whiteacres Superette|
      |174.7413968|-36.7584901|Civic Video & Lotto Sunnynook|
      |174.7410237|-36.75874936|Countdown Sunnynook|
      |174.6391077|-36.89253961|Sunnybrae Superette Henderson|
      |174.6357056|-36.8958191|Sunnyvale Superette|
      |174.5799941|-36.86553236|Swanson Superette and Post Centre|
      |174.9275968|-37.04872986|Countdown Takanini|
      |174.931166|-37.05283821|Pak n Save Papakura|
      |174.928827|-37.049794|Southgate Superette|
      |174.777901|-36.796674|Countdown Hauraki Corner|
      |174.7726066|-36.78834241|Magascene|
      |174.771374|-36.78888|Takapuna Dairy|
      |174.7652604|-36.7916094|Tom's Lucky Lotto Shop Takapuna|
      |174.7782052|-36.79690218|Valentines Stationers|
      |174.7706342|-36.78761304|Whitcoulls Shore City|
      |174.7568637|-36.78554538|Z Lakeside|
      |174.6506379|-36.85212295|Z Te Atatu|
      |174.652449|-36.84261|Countdown Te Atatu|
      |174.6467846|-36.83178492|Peninsula Foodmarket|
      |174.6506571|-36.84902513|Peninsula Price Cutter|
      |174.651533|-36.842309|Unichem Peninsula Pharmacy|
      |174.6468337|-36.86511899|Edmonton Stationery & Lotto|
      |174.644027|-36.859781|Sylvan Superette|
      |174.6457559|-36.87397717|Westside Superette|
      |174.7548318|-36.90929182|Countdown Three Kings|
      |174.754601|-36.909774|Joy Dairy|
      |174.654424|-36.927135|Kaurilands Superette|
      |174.6576892|-36.93762941|Titirangi Lotto, Postshop & Kiwibank|
      |174.6564259|-36.93759658|Titirangi Supervalue|
      |174.6379706|-36.94049734|Waima Superette & Video|
      |174.6617424|-36.92336109|Westview Superette|
      |174.750648|-36.694963|BK's Four Square|
      |174.7519345|-36.69556864|Video Ezy Torbay|
      |174.710852|-36.754486|Unsworth Heights Superette|
      |174.7401932|-36.77157694|Mobil Hillside|
      |174.544675|-36.849156|Waitakere Superette|
      |174.73253|-37.248905|Z Waiuku|
      |174.7020849|-36.87957042|Waterview Superette|
      |174.8862438|-37.05546622|Moor Park Superette|
      |174.639481|-36.813025|Westpark Superette|
      |174.728475|-36.868085|Caltex Western Springs|
      |174.608432|-36.820547|Pak n Save Westgate|
      |174.7179342|-36.85404095|Ramlax Dairy|
      |174.8653104|-37.04291358|Weymouth Superette|
      |174.6158318|-36.79341833|Shree Superette|
      |174.7422786|-36.73969249|Windsor Park Superette & Lotto|
      |174.891445|-37.003502|Rata Vine Foodmarket|
      |173.2558381|-35.04708833|Awanui Junction Dairy|
      |169.7433003|-46.23806339|Balclutha New World|
      |169.739871|-46.23786609|Ryders Paper Plus|
      |174.1206408|-35.31244902|Opua General Store|
      |173.9542399|-41.51367627|Countdown Blenheim|
      |173.9611063|-41.50235442|Midway Dairy & Takeaway|
      |173.9614479|-41.51400553|New World Blenheim|
      |173.9563712|-41.51241796|Paper Plus Blenheim|
      |173.9553|-41.53034659|Redwood Lotto|
      |173.954441|-41.528539|Countdown Redwoodtown|
      |173.9346257|-41.50915458|Countdown Springlands|
      |173.926867|-41.509248|Pak n Save Blenheim|
      |168.3436145|-46.59911127|Bluff Service Centre|
      |173.1100771|-41.37648179|Brightwater Four Square|
      |175.385309|-40.176389|Bulls Four Square|
      |175.4696525|-37.89158803|Countdown Cambridge|
      |175.472202|-37.893426|New World Cambridge|
      |175.477234|-37.882599|Robinson Street Superette|
      |175.4696276|-37.89456792|Victoria Station|
      |175.4690597|-37.89394949|Wayne's Lucky Lotto|
      |175.473289|-37.905572|Fresh Choice Leamington|
      |175.4749152|-37.90665129|Shakespeare Street Four Square|
      |175.5264093|-41.02583466|New World Carterton|
      |175.5291907|-41.023138|Smith Hare & Christison|
      |169.6024512|-45.09382792|Omakau Four Square|
      |173.2740725|-42.8126506|Cheviot Hardware|
      |172.547618|-43.490744|Countdown Christchurch Airport|
      |172.6428184|-43.53986758|Countdown Moorhouse|
      |172.636802|-43.513328|Edgeware Village Supervalue|
      |172.5903251|-43.50894105|Fendalton Village Superval Plus|
      |172.6378139|-43.53993705|Pak N Save Moorhouse|
      |172.6364737|-43.53748341|South City New World|
      |172.622162|-43.540199|Z Moorhouse|
      |172.6120184|-43.5435614|Addington Price Cutter & Lotto|
      |172.6048679|-43.5400384|Paper Tree|
      |172.6086056|-43.5459054|Z Addington|
      |172.700351|-43.507112|Wainoni Foodmarket|
      |172.6925919|-43.51204091|Wainoni Pak N Save|
      |172.559752|-43.524998|Avonlea Dairy|
      |172.556192|-43.51081256|Countdown Avonhead|
      |172.618653|-43.55703065|Fresh Choice Barrington|
      |172.6366331|-43.5533174|Countdown Colombo|
      |172.63245|-43.445345|Cosy Nook Dairy|
      |172.623169|-43.46072537|Countdown Northwood|
      |172.6277549|-43.45166795|Z Belfast|
      |172.5874971|-43.48857941|Bishopdale New World|
      |172.5893321|-43.48915778|Unichem Bishopdale Pharmacy|
      |172.585198|-43.49911167|Wairakei Road Supervalue|
      |172.6075278|-43.51047952|Z Bryndwr|
      |172.56403|-43.500685|Burnside Dairy|
      |172.6808961|-43.48240202|Burwood Food Market|
      |172.6469215|-43.56689878|Cashmere Super Dairy|
      |172.645172|-43.521331|Mobil Bealey Ave|
      |172.674173|-43.513744|Gayhurst Dairy|
      |172.645745|-43.513563|Barbadoes Food Store|
      |172.5884532|-43.51770745|Fendalton New World|
      |172.700371|-43.556431|Countdown Ferrymead|
      |172.7026485|-43.55736773|Take Note Ferrymead|
      |172.570834|-43.571964|BP 2 Go Halswell|
      |172.5703146|-43.58628549|Halswell Dairy|
      |172.5669658|-43.5802141|Halswell New World|
      |172.5442734|-43.488745|Relay Christchurch Airport|
      |172.528503|-43.538147|Z Hornby|
      |172.6725568|-43.55870217|Bus Stop Dairy|
      |172.5297067|-43.54259986|Countdown Hornby|
      |172.5258123|-43.54341876|Hornby Mall Lotto|
      |172.569634|-43.526341|Ilam New World|
      |172.5139745|-43.54069014|Islington Superette|
      |172.4867768|-43.55032616|Templeton Convenience Store|
      |172.488373|-43.54948|Z Templeton|
      |172.675416|-43.532004|Paper Plus Eastgate|
      |172.6564742|-43.51978753|Stanmore New World|
      |172.6570548|-43.53091419|Stanmore Supervalue|
      |172.6754278|-43.52529626|Woodham Foodmarket|
      |172.6712676|-43.53276226|Z Linwood|
      |172.6425058|-43.49763989|BP Mairehau|
      |172.649074|-43.496822|Hills Road Dairy|
      |172.6219486|-43.51255067|Fresh Choice Merivale|
      |172.7284797|-43.5076152|Countdown New Brighton|
      |172.727043|-43.507987|New Brighton Lotto & Discounter|
      |172.7288111|-43.50740672|Paper Plus New Brighton|
      |172.7105981|-43.49501379|QEII Foodmarket|
      |172.6733586|-43.53340076|Countdown Eastgate|
      |172.6160282|-43.48463838|The Mad Butcher Papanui|
      |172.6212785|-43.46001874|Northwood New World|
      |172.6570381|-43.54821532|Z Brougham St|
      |172.6107551|-43.49336849|Countdown Northlands|
      |172.6079845|-43.50985448|Elmwood Mini Market|
      |172.6092118|-43.49496541|Northlands Pak N Save|
      |172.6106068|-43.49231305|Whitcoulls Northlands|
      |172.6271516|-43.52009865|Z Carlton Corner|
      |172.711685|-43.486382|Bower Ave Food Market|
      |172.7060292|-43.48163959|Fresh Choice Parklands|
      |172.706181|-43.48184303|Parklands Lotto & Post|
      |172.5124494|-43.58096694|3 Arrows Prebbleton|
      |172.738595|-43.561533|Redcliffs Convenience Store|
      |172.738998|-43.562498|Redcliffs New World|
      |172.6168626|-43.47763741|Redwood Mini Market|
      |172.6113944|-43.52886102|Hagley Night N Day Foodstore|
      |172.588434|-43.538407|Kosco Blenheim Road|
      |172.6014375|-43.5294483|Kosco Riccarton|
      |172.5915901|-43.53022062|Naresh Foodstore|
      |172.5975066|-43.53007342|Pak N Save Riccarton|
      |172.5742624|-43.53175395|Paper Plus Bush Inn|
      |172.597418|-43.53014704|Whitcoulls Riccarton|
      |172.5678798|-43.53867103|Z Curletts Rd|
      |172.656183|-43.518273|Richmond Dairy|
      |172.3875668|-43.59507938|Countdown Rolleston|
      |172.542155|-43.522566|Cutts Mini Mart|
      |172.6628056|-43.50535332|Countdown The Palms|
      |172.662259|-43.499037|Moko Price Cutter|
      |172.662445|-43.507501|Z Shirley|
      |172.6273023|-43.55385239|Challenge Milton Street|
      |172.7324027|-43.52307627|Bridge Street Dairy|
      |172.612426|-43.55201|Bewdley Minimart|
      |172.6012496|-43.54981619|Lincoln Road Supervalue|
      |172.6185672|-43.55732793|Z Barrington|
      |172.6376251|-43.51342918|Kiwi Bookshop|
      |172.7597069|-43.56970591|Supervalue Sumner|
      |172.6366739|-43.55684581|Beckenham Lotto & News Agency|
      |172.6366393|-43.53773717|South City Lotto & Post|
      |172.5739867|-43.53199311|Countdown Church Corner|
      |172.7005446|-43.51780929|Laxmi Foodstore|
      |172.657844|-43.539777|Bronskis More Than a Dairy|
      |172.6470926|-43.54541609|Patel's Dairy and Foodmarket|
      |172.654364|-43.557875|St Martins New World Supermarket|
      |172.558056|-43.552614|Wigram New World|
      |172.6846084|-43.54945875|New World Ferry Road|
      |172.6707046|-43.54484948|PK's Dairy|
      |172.668086|-43.54341759|Z Woolston|
      |176.9162234|-39.581942|Clive Four Square|
      |169.3194575|-45.188589|Clyde Four Square|
      |172.682279|-40.676537|Collingwood on the Spot|
      |175.4975585|-36.76006867|Coromandel Four Square|
      |175.4984381|-36.75826761|Coromandel Super Saver With Lotto|
      |169.1950327|-45.03788844|Cromwell New World|
      |169.1982404|-45.03704816|Paper Plus Cromwell|
      |172.8482713|-42.77418578|Culverden Four Square|
      |176.102115|-40.208154|Caltex Westlow|
      |176.1090899|-40.20327624|Dannevirke Four Square|
      |176.0974076|-40.21001401|Dannevirke New World|
      |172.1066437|-43.48895342|Darfield Dairy|
      |173.8727363|-35.939823|Countdown Dargaville|
      |173.870654|-35.940698|Dargaville Four Square|
      |173.869821|-35.94146169|Dargaville Postshop & Lotto|
      |174.9519159|-37.10353039|Drury Lane Lotto Superette|
      |170.507343|-45.87070149|Centre City New World|
      |170.502512|-45.875633|City Mini Market Dunedin|
      |170.5087598|-45.89661858|Countdown Andersons Bay|
      |170.507299|-45.87324761|Countdown Dunedin|
      |170.502555|-45.892575|Countdown Dunedin South|
      |170.504542|-45.87224|Whitcoulls George Street|
      |170.50322|-45.892632|Z Andy Bay|
      |170.3303806|-45.94790387|Brighton Store|
      |170.4814669|-45.89626137|Caversham Foodmarket & Lotto|
      |170.505342|-45.87079489|Paper Plus Dunedin|
      |170.500628|-45.89638139|South Dunedin Night n Day|
      |170.4284465|-45.90198185|Fresh Choice Green Island|
      |170.42918|-45.90222613|Green Island Lucky Lotto and Milkbar|
      |170.4746883|-45.86971856|Foodlands Four Square|
      |170.472122|-45.872543|Z Valley|
      |170.2058124|-45.91536711|Paper Plus Dunedin Airport|
      |170.4792578|-45.88112164|Mornington Lotto & Post|
      |170.520524|-45.89780777|Musselburgh Food Centre|
      |170.5195949|-45.85486744|Gardens New World|
      |170.5337459|-45.84776922|Quarry Food Market|
      |170.620169|-45.817127|Port Chalmers Four Square|
      |170.489191|-45.86756628|Fresh Choice Roslyn|
      |170.5147255|-45.90517922|Tahuna Camp Store|
      |170.4998559|-45.89245193|Pak n Save Dunedin|
      |170.4780739|-45.85766649|Wakari Lotto & Post Centre|
      |176.8266506|-37.97560004|Gull Edgecumbe|
      |175.7030996|-40.64543117|Eketahuna Four Square & Lotto|
      |174.299321|-39.429975|Eltham Four Square|
      |170.8289023|-44.09932208|Fairlie Four Square|
      |175.325045|-41.117094|SuperValue Featherston|
      |175.5691365|-40.22438144|Countdown Feilding|
      |175.5633489|-40.22709474|Feilding Video Centre|
      |175.5646465|-40.22690362|Smiths Pharmacy|
      |175.2812072|-40.47195238|Take Note Foxton|
      |175.2401232|-40.46832121|Foxton Beach Four Square|
      |174.828577|-37.187775|Patumahoe Four Square|
      |170.1807251|-43.38831005|Franz Josef Four Square|
      |171.242241|-44.09102101|Fresh Choice Geraldine|
      |171.2435447|-44.09110207|Geraldine Books & Post|
      |178.0191513|-38.66171359|Countdown Gisborne|
      |178.02695|-38.6671484|Grant Bros.|
      |178.0249924|-38.66583573|House Of Gifts & Lotto|
      |178.046059|-38.675514|Kaiti Supervalue|
      |178.024418|-38.664622|Network Video Gisborne|
      |178.0215696|-38.6634955|Pak N Save Gisborne|
      |178.021064|-38.663207|Z Gisborne|
      |177.9960426|-38.65694399|Elgin Four Square|
      |178.0334344|-38.66997686|Ideal Store|
      |178.010628|-38.643128|Mangapapa Four Square|
      |178.0028258|-38.64048389|Lytton West Post & Lotto|
      |178.368996|-37.63318|Eastern Store|
      |177.8637862|-38.46952359|Rangatira Motors|
      |168.9446051|-46.09869283|Countdown Gore|
      |168.9422737|-46.09980416|New World Gore|
      |168.9453191|-46.0998859|Paper Plus Gore|
      |168.9440049|-46.10162456|United Video Gore|
      |171.213472|-42.44869822|Countdown Greymouth|
      |171.1956186|-42.46291082|Greymouth New World|
      |171.2106839|-42.4485275|On the Spot & Lotto Greymouth|
      |171.172655|-42.500394|Four J's Takeaways|
      |175.452783|-41.087093|Challenge Greytown|
      |175.459058|-41.080673|Fresh Choice Greytown|
      |175.293217|-37.77235589|5 Cross Roads Post & Paper|
      |175.286951|-39.973762|Countdown Bridge Street|
      |175.2735596|-37.78126214|Countdown Hamilton|
      |175.2731747|-37.73075306|Countdown St James|
      |175.308953|-37.789866|Hillcrest Four Square|
      |175.280533|-37.78580141|Whitcoulls Centre Place|
      |175.2799721|-37.75146238|Chartwell Lotto|
      |175.284828|-37.756206|Crosby Road Superette|
      |175.267530|-37.759993|River Road Foodmarket|
      |175.2797221|-37.75090799|Whitcoulls Chartwell|
      |175.294123|-37.749259|Parkwood Supervalue|
      |175.235558|-37.0797351|Caltex Dinsdale|
      |175.245917|-37.795390|Countdown Dinsdale|
      |175.245419|-37.79559073|Take Note Dinsdale|
      |175.2432576|-37.80335511|Tuhikaramea Superette|
      |175.2473317|-37.79515445|Z Dinsdale|
      |175.2929968|-37.77255881|Z Five Crossroads|
      |175.2871472|-37.76171719|Davies Corner Foodmarket|
      |175.2829609|-37.77117497|Heaphy Terrace Four Square|
      |175.30385|-37.76548984|Fairview Downs Superette|
      |175.252124|-37.738442|Flagstaff Supervalue|
      |175.2523283|-37.77796032|Underpass Superette|
      |175.2590797|-37.80597657|Ezi Park Superette|
      |175.264769|-37.78804862|Frankton Lotto & Stationery|
      |175.2875433|-37.82243375|Glenview Centre Lotto & Stationery|
      |175.306446|-37.670598|Gordonton Superette|
      |175.2826237|-37.78648197|City Mart|
      |175.280318|-37.786870|Paper Plus Hamilton|
      |175.298226|-37.790166|Best Choice Mini Mart|
      |175.289591|-37.782465|Claudelands Food Centre|
      |176.298914|-37.779732|Countdown Claudelands|
      |175.293581|-37.79288|Eastside Mags and More|
      |175.296140|-37.798760|Grey Street Supermarket|
      |175.2818802|-37.79447597|Pak N Save Clarence Street|
      |175.281286|-37.803243|Selwyn Street Dairy|
      |175.2712977|-37.80744491|Z K Drive|
      |175.3105472|-37.79734409|Cambridge Road Dairy|
      |175.3223068|-37.80174055|Hillcrest New World|
      |175.3226095|-37.8013784|Video Ezy Hillcrest & PostShop|
      |175.258324|-37.780171|Shop Rite Dairy|
      |175.2870974|-37.8084393|Bader Street Mini Mart|
      |175.282624|-37.817484|Glenview Food Centre|
      |175.273998|-37.815717|Kingsway Superette|
      |175.280498|-37.808599|R-Jays Superette|
      |175.24542|-37.78396|JB Superette|
      |175.2362088|-37.78108192|Nawton Stationers & Lotto|
      |175.241761|-37.772919|Sai Baba Foodmarket|
      |175.3355136|-37.86575058|The Store Hamilton Airport|
      |175.3949865|-37.8043186|Matangi General Store|
      |175.1526628|-37.74328506|Te Kowhai Foodcentre|
      |175.2733181|-37.73567082|Rototuna FoodMart|
      |175.2730587|-37.7304504|New World Rototuna|
      |175.274977|-37.728674|Paper Plus Rototuna|
      |175.3260694|-37.78988749|Silverdale Four Square|
      |175.2489071|-37.74858511|Bryant Park Mini Supermarket|
      |175.2592352|-37.75750483|St Andrews Dairy|
      |175.2329646|-37.7462957|Countdown Te Rapa|
      |175.2407411|-37.75288629|New World Te Rapa|
      |175.2340037|-37.7484817|Paper Plus - The Base|
      |175.2354993|-37.74985233|Whitcoulls The Base|
      |175.2409771|-37.75229649|Z Pukete|
      |175.2528188|-37.76445057|Te Rapa Lucky Lotto|
      |175.2737558|-37.77802873|Mill St. Pak N Save|
      |175.271389|-37.780529|Z Stadium|
      |172.829353|-42.52122418|Hanmer Four Square|
      |176.846044|-39.640496|Bay Plaza Pharmacy|
      |176.8424561|-39.63922831|Countdown Hastings|
      |176.8451615|-39.64371072|Denton Wyatt Bookshop|
      |176.8464546|-39.64474319|Hastings City New World|
      |176.8454733|-39.64033687|Paper Plus Hastings|
      |176.838448|-39.637839|Z Heretaunga Street|
      |176.7888171|-39.62613272|Flaxmere Pharmacy|
      |176.777648|-39.621088|Scott Drive Four Square|
      |176.827923|-39.622574|Frimley Four Square|
      |176.8505742|-39.62825579|Mahora Four Square|
      |176.8557968|-39.65254772|East End Four Square|
      |176.8521906|-39.63804868|Caltex Karamu Road|
      |176.8379046|-39.63716005|Pak N Save Hastings|
      |176.8318|-39.63085356|Unichem Stortford Lodge Pharmacy|
      |176.8109033|-39.61766356|Caltex Omahu Road|
      |176.9571711|-39.61600137|Cape View Four Square|
      |175.4530943|-37.86046801|Hautapu Country Store|
      |176.8775057|-39.6702575|Take Note Havelock North|
      |176.8962706|-39.667822|Te Mata Four Square|
      |176.876771|-39.671153|Village Lotto and Gifts|
      |173.7667303|-41.2778042|Havelock Four Square|
      |174.2813206|-39.58864061|@ Your Office & Lotto|
      |174.281547|-39.587509|Countdown Hawera|
      |174.2833229|-39.58923031|Loveridges Lotto & Video|
      |174.2834483|-39.590741|Pak N Save Hawera|
      |174.281566|-39.5939044|Z Hawera|
      |174.150518|-39.429313|Kaponga Four Square|
      |174.451131|-36.677272|Countdown Helensville|
      |174.4506771|-36.67638908|Take Note Helensville|
      |174.28649|-35.59717459|Hikurangi Four Square|
      |170.9693889|-42.71400889|Fitzherbert Street Four Square|
      |170.9625325|-42.7164753|Hokitika New World|
      |170.97136|-42.719541|Stafford Street Four Square|
      |175.5685387|-39.93706017|Taylor's Four Square|
      |175.1610357|-37.53640843|Freds Four Square|
      |175.1588432|-37.55967705|The Bookshop and Lotto|
      |175.1582674|-37.56804476|Countdown Huntly|
      |175.158401|-37.567493|Z Huntly|
      |174.2077533|-39.1560665|Inglewood Bookcentre|
      |174.207324|-39.158185|Shoprite Inglewood|
      |174.20547|-39.1559279|Z Inglewood|
      |168.3580061|-46.41301933|Countdown Invercargill|
      |168.3528724|-46.41302569|Pak N Save Invercargill|
      |168.3546898|-46.40875838|Plaza Supervalue|
      |168.3491578|-46.41177181|Whitcoulls Invercargill|
      |168.3656066|-46.39603314|Windsor New World|
      |168.3469751|-46.40510834|Z Dee St|
      |168.3476099|-46.39302054|Z Gladstone|
      |168.3473993|-46.40063718|Avenal Dairy and Lotto|
      |168.3472555|-46.39317026|Dee Night n Day|
      |168.3913163|-46.41786752|Newfield Four Square|
      |168.2968785|-46.43200106|Otatara Four Square|
      |168.3614479|-46.42734627|Elles Rd New World|
      |168.3614416|-46.4277425|South City Gifts & Lotto|
      |168.3473295|-46.38479271|Collingwood Foodcentre|
      |168.3468845|-46.37546373|Countdown Waikiwi|
      |168.3658057|-46.39822161|Windsor Stationery & Lotto|
      |173.7832551|-35.10094166|Kaeo Four Square|
      |172.642955|-43.38565|Caroline Dairy|
      |172.6575464|-43.38520273|Countdown Kaiapoi|
      |172.6596145|-43.38301869|Kaiapoi New World|
      |173.800143|-35.407209|Kaikohe Four Square|
      |173.7990305|-35.40808121|Kaikohe Paper Plus|
      |173.8009207|-35.40917241|New World Kaikohe|
      |173.392184|-35.504735|Opononi Four Square|
      |173.6795619|-42.38794598|Kaikoura New World|
      |173.6824427|-42.40236376|Paper Plus Kaikoura|
      |173.2643041|-35.11458278|Marston Moor|
      |173.2589657|-35.09889586|Pak N Save Kaitaia|
      |173.1182444|-34.81462103|Houhora Wharf Four Square|
      |174.4438879|-36.16088991|Jaques Four Square|
      |172.1284893|-41.2515598|Karamea Four Square Supermarket|
      |175.555214|-37.917048|Mobil Karapiro|
      |175.9160542|-37.55968736|Countdown Katikati|
      |175.9167844|-37.55487778|Video Ezy Katikati|
      |175.9173961|-37.55279202|Katikati Paper Plus and Post Shop|
      |174.493739|-36.61675617|Kaukapakapa Store|
      |174.0681958|-35.38004686|Hammer Hardware Kawakawa|
      |176.684203|-38.0897598|Ballantrae Four Square|
      |176.7016534|-38.08794707|Kawerau Foodmarket & Lotto|
      |176.7019184|-38.08501181|Z Kawerau|
      |176.7012646|-38.08542376|Smiths City|
      |173.946677|-35.2295224|Countdown Kerikeri|
      |173.9503037|-35.22613715|New World Kerikeri|
      |174.554581|-36.77455899|Kumeu Four Square|
      |174.553930|-36.775037|New World Kumeu|
      |169.6865928|-45.91293277|Lawrence Four Square Supermarket|
      |172.2980239|-43.76265757|Fresh Choice Leeston|
      |175.2862192|-40.6204092|Countdown Levin|
      |175.2864247|-40.62203241|Levin Lucky Lotto|
      |175.2855093|-40.62292443|Levin Mall Lotto|
      |175.2833225|-40.62317168|Levin New World|
      |175.2763266|-40.63200835|Z Levin|
      |172.483944|-43.640526|Lincoln Convenience Store|
      |172.4743558|-43.6415454|Lincoln New World|
      |174.9049346|-41.20822551|Countdown Lower Hutt|
      |174.906682|-41.210946|Countdown Queensgate|
      |174.904493|-41.20994648|Halo Lotto & Convenience|
      |174.9070066|-41.20893897|Hutt City New World|
      |174.9065853|-41.21082746|Life Pharmacy Queensgate|
      |174.9126086|-41.20606363|Pak N Save Lower Hutt|
      |174.934976|-41.17984|Stellin Street Store|
      |174.9061498|-41.2104705|Whitcoulls Queensgate|
      |174.890717|-41.216937|Masala's & Alicetown Lotto|
      |174.94355|-41.193735|Avalon Mini Mart|
      |174.8970811|-41.2900487|Eastbourne Four Square|
      |174.929536|-41.20742|Epuni Mini Market|
      |174.9287361|-41.18694116|Kelson General Store|
      |174.8783316|-41.20796853|Dowse Drive Foodmarket|
      |174.9053685|-41.22709391|Moera Corner Dairy and Lotto|
      |174.9475482|-41.19910091|Golden Nugget Lotto Shop|
      |174.94777|-41.198459|Naenae Four Square|
      |174.872249|-41.222738|Countdown Petone|
      |174.889227|-41.22843|J & S Foodmarket|
      |174.87214|-41.22348685|Pak N Save Petone|
      |174.8802582|-41.22580513|Paper Plus Select Petone|
      |174.981995|-41.161654|Caltex Stokes Valley|
      |174.9809272|-41.17459089|New World Stokes Valley|
      |174.9816882|-41.17413475|NY Court Dairy|
      |174.9613884|-41.17908186|BP Taita|
      |174.932663|-41.25692|Carnation Superette|
      |174.9436254|-41.25983844|Countdown Wainuiomata|
      |174.954299|-41.27233325|Village Store Wainuiomata|
      |174.9438045|-41.25988438|Wainuiomata Pharmacy|
      |174.910949|-41.222625|SuperValue Woburn|
      |174.914647|-41.223744|Wainui Road Dairy|
      |174.922513|-41.214151|Waterloo Lotto and Giftshop|
      |168.4415952|-45.73972141|Lumsden Lotto & Dairy|
      |172.721233|-43.602484|London Street Dairy|
      |172.721482|-43.602807|Lyttelton Supervalue|
      |177.8709708|-39.08843918|Mahia Beach Store|
      |174.1257912|-39.55086068|Manaia Four Square|
      |175.7740682|-38.37070131|Mangakino Four Square|
      |174.5868089|-36.09494154|Molesworth Four Square|
      |173.5361836|-34.9915233|Mangonui Stationery & Lotto|
      |173.0957943|-41.25318624|Mapua Four Square Supermarket|
      |175.458919|-41.21866963|Pain & Kershaw|
      |175.3793893|-40.07667638|New World Marton|
      |175.6583939|-40.95186998|Copper Kettle|
      |175.6580426|-40.95218927|Countdown Masterton|
      |175.673839|-40.945888|Hospital Foodmarket|
      |175.6642412|-40.94833934|New World Masterton|
      |175.6488577|-40.95728256|Pak N Save Masterton|
      |175.660215|-40.950747|Paper Plus Masterton|
      |175.637714|-40.946471|Renall Street Store|
      |175.64876|-40.95790131|Kuripuni Lotto and Post Shop|
      |175.623772|-40.962071|Solway Four Square|
      |174.7168756|-36.35189599|Matakana Four Square|
      |175.7697934|-37.80319367|New World Matamata|
      |175.7739157|-37.80985049|Paper Plus Matamata|
      |168.8623238|-46.195895|Clutterbucks Four Square|
      |174.3488976|-36.11279665|Tony's Stationery & Lotto|
      |171.6452465|-43.63301725|Methven Four Square|
      |171.6463662|-43.63323903|Methven Supervalue|
      |169.95638|-46.12339549|Milton Night n Day|
      |169.958658|-46.121885|Milton Supervalue|
      |169.964368|-46.116405|Tokomairiro Four Square|
      |171.482906|-42.572175|Lake Brunner Service Centre|
      |174.0138726|-35.388138|Blue Lagoon Four Square|
      |175.5225557|-37.65981385|Morrinsville New World|
      |175.52702|-37.657902|Paper Plus Morrinsville|
      |175.5313048|-37.65669844|SDR Fuel Ltd|
      |170.3485662|-45.87555499|Monte Carlo Milkbar|
      |170.3498718|-45.87180498|Mosgiel New World|
      |170.354054|-45.8861731|Z Mosgiel|
      |170.3370918|-45.89793739|East Taieri Dairy|
      |173.0108962|-41.10972508|Countdown Motueka|
      |173.0111918|-41.11460496|Motueka New World|
      |176.2231352|-37.67576032|Bayfair Lotto|
      |176.230843|-37.67284615|Girven Road Micro Mart|
      |176.176608|-37.632552|Hot Spot Superette|
      |176.1989757|-37.65396498|Mt Maunganui New World|
      |176.2006247|-37.65591838|Mt Paper Power|
      |176.1992385|-37.66597123|Z Hewletts Rd|
      |172.3257032|-41.80028795|Murchison Four Square|
      |176.7051674|-38.45730742|Murupara Four Square|
      |176.911328|-39.4921703|Countdown Carlyle|
      |176.880136|-39.511213|Napier Food Mart|
      |176.917092|-39.49138258|Paper Plus Napier|
      |176.911452|-39.493614|Z Kennedy Road|
      |176.8965834|-39.48264358|Ahuriri Four Square|
      |176.8664969|-39.41899191|Bay View Four Square|
      |176.912734|-39.484932|Shakespeare Road Mini Market|
      |176.8624458|-39.52522236|Greenmeadows New World|
      |176.8610289|-39.52649496|Greenmeadows Pharmacy|
      |176.904282|-39.514362|Maraenui Four Square|
      |176.898339|-39.494963|Caltex Hyderabad|
      |176.892244|-39.498256|League Park Superette|
      |176.902574|-39.500545|Marewa Four Square|
      |176.9134282|-39.49329979|Countdown Napier|
      |176.9134559|-39.49482823|Napier City Pak N Save|
      |176.8871645|-39.5083401|Andrew Spence Pharmacy|
      |176.8875098|-39.50867888|New World Onekawa|
      |176.8702699|-39.51081541|Tamatea Pak n Save|
      |176.848174|-39.53624|Paper Plus Taradale|
      |176.8492273|-39.53445471|Taradale Four Square|
      |175.402232|-39.176957|National Park Four Square|
      |173.2427346|-41.30120856|Black Cat Store|
      |173.2776136|-41.27250727|Countdown Nelson|
      |173.2872148|-41.27206373|Fresh Choice Nelson City|
      |173.2780827|-41.2749074|Nelson City New World|
      |173.2841579|-41.27378477|Paper Plus Nelson|
      |173.2838977|-41.2737682|Whitcoulls Nelson|
      |173.1794751|-41.33776859|Z Richmond|
      |173.317482|-41.236704|Atawhai 4 Square Supermarket|
      |173.266701|-41.295442|Caltex Bishopdale Nelson|
      |173.2700091|-41.28088796|Victory on the Spot|
      |173.1860879|-41.34021978|Fresh Choice Richmond|
      |173.1864402|-41.33818167|Pak N Save Richmond|
      |173.1857764|-41.34025758|Richmond Night N Day|
      |173.2340707|-41.31179759|Countdown Stoke|
      |173.2322024|-41.31253313|Stoke New World|
      |172.8237179|-41.38900233|Tapawera Four Square|
      |173.2947271|-41.26914886|Milton Street Store|
      |174.0819381|-39.05744838|Countdown New Plymouth Central|
      |174.0335917|-39.07576751|Countdown Spotswood|
      |174.1161474|-39.04701414|Countdown The Valley|
      |174.0782681|-39.05669539|Devon Lotto 'N' Treats|
      |174.0732989|-39.05789073|Mainly Magazines and Lotto|
      |174.0797497|-39.05728806|New World New Plymouth|
      |174.0794916|-39.05693647|Pak N Save New Plymouth|
      |174.0764184|-39.05723338|Paper Plus New Plymouth|
      |174.0741963|-39.05656401|Whitcoulls New Plymouth|
      |174.110411|-39.0510947|Z Waiwhakaiho|
      |174.142784|-39.035753|Bell Block Four Square|
      |174.1492905|-39.02841488|Parklands Supervalue|
      |174.0425399|-39.06745169|Blagdon Four Square|
      |174.1018106|-39.04943631|Fitzroy Lotto & Mags|
      |174.1031183|-39.0670091|Merrilands Lotto & Post|
      |174.1028677|-39.06658958|New World Merrilands|
      |174.045911|-39.063375|Moturoa Four Square|
      |174.3900503|-38.9978758|Urenui Four Square|
      |174.083082|-39.077609|Countdown Vogeltown|
      |174.0854858|-39.08051081|Vogeltown Four Square|
      |174.0628854|-39.07033499|Westown Lotto|
      |175.1501283|-37.66691193|New World Ngaruawahia|
      |175.1482538|-37.66589898|Pharos Post & Lotto|
      |175.1580958|-37.67439542|Supervalue Ngaruawahia|
      |175.496185|-37.276492|Ngatea Four Square|
      |175.4960996|-37.27609941|Ngatea Lotto & Foodmart|
      |170.8172708|-45.32380426|Hampden Four Square|
      |173.5097571|-34.99215636|Coopers Beach Four Square|
      |174.0030398|-39.09756732|Oakura Four Square|
      |170.9707368|-45.09743383|Countdown Oamaru|
      |170.9549305|-45.10220016|Oamaru New World|
      |170.9713943|-45.09683129|Paper Plus Oamaru|
      |170.968048|-45.09832|Z Oamaru|
      |170.9822061|-45.08083306|Lotto 'N' Things|
      |170.985603|-45.07690389|Northside New World|
      |175.3987222|-39.4178171|Take Note Ohakune|
      |175.3070156|-37.91858736|Ohaupo Store|
      |177.03578|-37.964119|Beach Haven Ohope|
      |177.0522008|-37.96969227|Ohope Four Square|
      |174.779086|-36.339961|Omaha Beach Superette|
      |169.9659931|-44.48828374|Omarama Four Square|
      |176.0523234|-37.6325949|Omokoroa Beach Store|
      |177.28687|-38.01120123|Blue Moon Four Square|
      |177.276758|-38.012093|Opotiki New World|
      |177.2847141|-38.00512381|Opotiki Pharmacy|
      |177.6765635|-37.73967682|Te Kaha Holiday Park|
      |173.8591|-39.454222|Highway 45 Four Square|
      |174.6958321|-36.58820117|Countdown Orewa|
      |174.6790166|-36.58873955|Grand Superette|
      |174.693625|-36.586542|New World Orewa|
      |174.6955641|-36.58644109|Orewa Lotto Plus|
      |170.7144712|-45.48422474|Palmerston Four Square|
      |170.0993858|-45.1299442|More than Books|
      |175.1703509|-40.74298353|Otaki New World|
      |175.1390005|-40.75263|Otaki Post and Lotto|
      |167.9974444|-46.1432742|Otautau Supervalue|
      |175.209828|-38.189814|Countdown Otorohanga|
      |175.2115744|-38.18630265|Paper Plus Otorohanga|
      |170.2311896|-45.85660105|Mitchell's Family Foodcentre|
      |169.6604934|-46.45137991|Owaka Four Square|
      |172.1917335|-43.29790539|Oxford Fresh Choice|
      |175.668218|-37.378442|Countdown Paeroa|
      |175.6715372|-37.38084918|Paeroa Four Square|
      |175.6698237|-37.37944932|Take Note Paeroa|
      |175.8419229|-40.45188845|Paper Plus Select Pahiatua|
      |174.091040|-35.282229|Countdown Paihia Central|
      |174.080992|-35.279232|Countdown Waitangi|
      |174.0905359|-35.28243875|Paihia Four Square|
      |175.623394|-40.350511|Countdown Broadway|
      |175.6062154|-40.3500778|Countdown Rangitikei Street|
      |175.6122535|-40.35543966|Inner City Post & Lotto|
      |175.6246155|-40.34866218|Melody's New World|
      |175.6126598|-40.35984551|Pak N Save Palmerston North|
      |175.6004966|-40.36061237|Pioneer New World|
      |175.6118363|-40.3574404|Plaza Lotto|
      |175.620987|-40.323377|Relay Palmerston North Airport|
      |175.6125214|-40.3544034|Whitcoulls P.N Broadway|
      |175.593105|-40.3647314|Z Pioneer Highway|
      |175.7551482|-40.28977572|Village Four Square Lotto|
      |175.5851218|-40.37970634|Awapuni Four Square|
      |175.5851358|-40.3510603|Cloverlea Four Square|
      |175.6395866|-40.38752583|Aokautere New World|
      |175.5858942|-40.35981308|Highbury Four Square|
      |175.635329|-40.36485249|Hokowhitu Four Square & Lotto|
      |175.653062|-40.330025|Countdown Kelvin Grove|
      |175.6377628|-40.32738961|Kaimanawa Four Square|
      |175.6149928|-40.33162616|Super Seven Four Square|
      |175.633144|-40.346102|Caltex Terrace End|
      |175.631119|-40.3315829|Vogel Street Pharmacy|
      |175.629381|-40.348567|Z Terrace End|
      |175.63824|-40.347176|Limbrick Street Maxi Mart|
      |175.616398|-40.362392|Caltex Fitzherbert|
      |175.606837|-40.3661|Top Cook Dairy|
      |175.5763943|-40.35771101|Havelock Ave Four Square|
      |174.9432371|-37.06395499|Countdown Papakura|
      |174.940708|-37.05953343|Countdown Roselands Papakura|
      |174.9431876|-37.06960083|Mobil Papakura|
      |174.9434358|-37.06422183|Papakura Photo Image|
      |174.9547475|-37.06620293|Supervalue Settlement Road|
      |174.9642804|-37.05383769|Keri Hill Superette|
      |174.942066|-37.06269607|Pharmacy Plus Papakura|
      |174.9405545|-37.05971266|Roselands Lotto|
      |174.8843684|-37.13867882|Caltex Karaka|
      |175.072573|-37.082448|Hunua Mini Supermarket|
      |174.9369199|-37.07909121|Edinburgh Foodmarket|
      |176.2838143|-37.69860895|My Pharmacy Papamoa Plaza|
      |176.2837923|-37.70179434|Pak n Save Papamoa|
      |176.3428133|-37.7175329|Papamoa Beach Four Square|
      |176.2836251|-37.69675967|Papamoa Superette|
      |176.316643|-37.708655|Papamoa Beach Superette|
      |176.3309254|-37.71358443|Papamoa Super Seven|
      |176.284393|-37.69912|Z Palm Beach|
      |174.4337653|-36.6615534|Parakai Four Square|
      |175.0041531|-40.91638426|Coastlands Lotto|
      |174.9973822|-40.90566381|Kapiti Four Square|
      |175.0025698|-40.917912|Kapiti Pak N Save|
      |174.99473|-40.905437|New World Kapiti|
      |174.9975582|-40.90663842|Z Kapiti Rd|
      |174.9803137|-40.89434788|Diana's Lotto|
      |174.9937243|-40.88247609|Kena Kena Four Square|
      |174.981555|-40.919038|Raumati Beach Four Square|
      |174.977499|-40.936524|Raumati South Four Square|
      |174.473483|-39.755876|Patea Four Square|
      |175.864219|-37.02336475|Pauanui Supervalue|
      |172.698098|-43.314563|Pegasus General Store|
      |174.0067622|-41.29243828|Fresh Choice Picton|
      |174.017213|-41.286494|On the Spot Picton|
      |174.0065447|-41.29036171|Picton Four Square Supermarket|
      |175.0157941|-38.4665723|Pio Pio Superette|
      |175.2002523|-37.99123556|Pirongia Four Square|
      |171.1313845|-44.26097074|Pleasant Point Dairy|
      |175.022078|-37.24600165|Pokeno Superette|
      |176.489888|-37.822174|BP 2 Go Pongakawa|
      |174.8392984|-41.13552666|Centre Food Store|
      |174.8412406|-41.13371473|Countdown Porirua|
      |174.8420371|-41.13730269|New World Porirua|
      |174.8415208|-41.13186664|Pak N Save Porirua|
      |174.8660914|-41.1427427|Bedford Four Square|
      |174.8395486|-41.13749088|North City Lotto|
      |174.831963|-41.124253|Takapuwahia Superette|
      |174.8689653|-41.09399074|Paremata New World|
      |174.9165175|-41.10466722|Pauatahanui General Store|
      |174.8654869|-41.08225103|Plimmerton Four Square|
      |174.841773|-41.136603|Paper Plus North City|
      |174.843255|-41.108218|Morere Four Square|
      |174.8382514|-41.10819138|Titahi Bay Four Square|
      |174.8800145|-41.12899794|Waitangirua Four Square|
      |174.8936874|-41.11721907|Whitby New World|
      |174.8499986|-41.13920067|Eastside Four Square & Lotto|
      |170.6214353|-45.81563871|Windsor On the Spot Express|
      |174.731332|-37.386125|Port Waikato Store & Post Centre|
      |174.9014725|-37.19924352|Countdown Pukekohe|
      |174.9106749|-37.21150349|Countdown Pukekohe South|
      |174.9099895|-37.21446733|Fresh n Save Pukekohe|
      |174.899495|-37.216925|Hill Superette|
      |174.9024373|-37.18994813|Lochview Dairy|
      |174.9003242|-37.20527735|Pak N Save Pukekohe|
      |174.9023468|-37.2005568|Paper Plus Pukekohe|
      |174.7515234|-37.13741711|Waiau Pa Four Square|
      |175.7821582|-38.04491026|Challenge Putaruru|
      |175.7788446|-38.05162167|Nana's Toybox|
      |168.6620791|-45.02958673|Alpine Supermarket|
      |168.6615582|-45.02514247|Fresh Choice Queenstown|
      |168.7396202|-45.01965619|Paper Plus Queenstown Airport|
      |168.6602305|-45.03183798|Whitcoulls Queenstown|
      |168.7160773|-45.0173297|Z Queenstown|
      |168.747429|-45.015836|Countdown Queenstown|
      |168.7434008|-45.02572333|Wakatipu New World|
      |168.741888|-45.026478|Whitcoulls Remarkables|
      |175.2777231|-39.42667343|Pricecutter Four Square Raetihi|
      |174.870662|-37.800719|Raglan Four Square|
      |174.869313|-37.799777|Raglan Supervalue|
      |172.0251252|-43.75618434|Rakaia Mobil|
      |172.598068|-43.306865|Countdown Rangiora East|
      |172.5958972|-43.30332078|Gift And Lotto Shop|
      |172.558056|-43.552614|Pak N Save Rangiora|
      |172.593364|-43.303515|Paper Plus Rangiora|
      |172.5944065|-43.30169768|Rangiora New World Supermarket|
      |174.6976631|-36.60545343|Red Beach Four Square|
      |171.864461|-42.119582|This That & Lotto|
      |173.8247982|-41.50850023|Renwick Dairy|
      |173.825624|-41.50813|Renwick Supervalue|
      |176.3407309|-38.43574364|Reporoa Foodmarket|
      |174.592006|-36.75695596|Riverhead Mini Market|
      |168.0133664|-46.35233951|Riverton Supervalue|
      |172.3719448|-43.59850722|Rolleston New World|
      |175.4255005|-40.29259291|Rongotea Four Square|
      |176.2516793|-38.13952223|City Books & Lotto|
      |176.251228|-38.134714|Dianne Dairy|
      |176.2516609|-38.13590715|Lucky Lotto Shop|
      |176.2383721|-38.14755945|New World Westend|
      |176.2538497|-38.14078516|Pak N Save Rotorua|
      |176.2517105|-38.14095875|Paper Plus Central|
      |176.2532788|-38.14195586|Z Fenton Street|
      |176.228110|-38.120414|Countdown Fairy Springs|
      |176.230606|-38.123055|Z Fairy Springs|
      |176.2251823|-38.14754565|Fordlands Four Square|
      |176.2382628|-38.12007598|Koutu Four Square|
      |176.214516|-38.136572|Edmund Road Four Square|
      |176.2126738|-38.08003916|Ngongotaha Books Lotto & Postshop|
      |176.2119807|-38.08107976|Ngongotaha Four Square|
      |176.3025636|-38.12949667|Eastside Pricecutter|
      |176.294875|-38.134107|Te Ngae Four Square|
      |176.295896|-38.13373321|Te Ngae Hardware & Lotto|
      |176.223274|-38.11773456|Selwyn Heights Four Square|
      |176.22611|-38.116309|Skylane Superette|
      |176.2358049|-38.16027404|Springfield Superette & Lotto|
      |176.3177817|-38.10934587|Relay Rotorua Intl Airport|
      |176.237219|-38.144917|Westend Dairy & Post Shop|
      |176.254151|-38.14337605|Countdown Rotorua|
      |176.2194934|-38.1290643|Western Heights Foodmarket|
      |169.3147656|-45.54049948|Roxburgh Supervalue|
      |174.456405|-35.87374143|Sweet Gifts|
      |178.3030512|-37.90136546|Hikurangi Foodmarket|
      |174.0246889|-36.13571975|Ruawai Four Square|
      |174.1216466|-35.26194136|Russell Four Square|
      |175.423065|-40.219646|Z Sanson|
      |174.0760763|-41.67354396|Seddon Supervalue|
      |175.4122822|-40.54640227|Shannon Four Square|
      |174.683728|-36.613841|Countdown Silverdale|
      |174.678511|-36.604814|Millwater Superette|
      |174.672763|-36.620926|Pak N Save Silverdale|
      |173.961882|-41.460278|Spring Creek Four Square|
      |168.1281961|-46.8974348|Ship To Shore Four Square|
      |174.279519|-39.327169|Countdown Stratford|
      |174.2849607|-39.33769294|New World Stratford|
      |174.2844256|-39.33917546|Paper Plus Stratford|
      |174.287386|-39.345083|Stratford Four Square|
      |174.283593|-39.3375307|Z Stratford|
      |175.798476|-39.677239|New World Taihape|
      |175.7995334|-39.67875625|Spacey's Video World|
      |173.465780|-34.996455|Taipa Foodmarket|
      |175.8496147|-36.99630406|Tairua Lotto & Stationery|
      |172.8064271|-40.86149308|Fresh Choice Takaka|
      |172.8058779|-40.85951548|Take Note Takaka|
      |174.9198438|-37.03922643|Manuroa Superette|
      |174.919411|-37.039274|Supervalue Takanini|
      |174.910243|-37.046803|Conifer Grove Dairy|
      |174.9136345|-37.03944292|Takanini Superette|
      |177.0043214|-38.0659923|Fuelstop|
      |169.2607862|-45.94331689|Tapanui Dairy|
      |173.8000644|-39.3302889|Rahotu Four Square|
      |175.2631284|-38.88304231|Paper Plus Taumarunui|
      |175.2581966|-38.88315028|Taumarunui New World|
      |176.0705225|-38.68408141|Countdown Taupo|
      |176.073526|-38.686059|Pak n Save Taupo|
      |176.0714529|-38.68810806|Paper Plus Taupo|
      |176.0806044|-38.69113018|Praters Four Square|
      |176.0711665|-38.68964907|United Video Taupo|
      |176.1100585|-38.70422246|Z Tauhara|
      |176.0608826|-38.68087667|Kemps General Store|
      |176.0911465|-38.71521872|Richmond Superette|
      |176.0952935|-38.68464526|Paetiki Lotto Magazines & Post|
      |176.1697471|-37.68470077|AJ's Lotto|
      |176.1649951|-37.68931607|John's Photo Pharmacy|
      |176.1787478|-37.71642832|Maungatapu Stationers|
      |176.1603236|-37.69676912|Pak n Save Tauranga|
      |176.1830285|-37.63732116|Paper Plus Mt Maunganui|
      |176.1685382|-37.68532097|Tauranga City Lotto|
      |176.1590991|-37.69789063|Z 11th Ave|
      |176.1092374|-37.69588022|Bethlehem Four Square & Lotto|
      |176.129346|-37.702766|Cambridge Heights Foodmarket|
      |176.108716|-37.69518|Countdown Bethlehem|
      |176.109629|-37.693662|Video Ezy Bethlehem|
      |176.1069681|-37.69606422|Z Bethlehem|
      |176.1356667|-37.69078459|Brookfield Foodmart and Lotto|
      |176.1344906|-37.69001208|New World Brookfield|
      |176.1520464|-37.71320284|Countdown Fraser Cove|
      |176.1423889|-37.71310808|Gate Pa Superette|
      |176.1429351|-37.7131699|New World Gate Pa|
      |176.1355985|-37.72752358|Chadwick Stationery, Gifts & Lotto|
      |176.1636332|-37.73442677|Ohauiti Four Square|
      |176.1335924|-37.66489373|Matua Dairy|
      |176.038839|-37.641072|Fresh Choice Omokoroa|
      |176.1535464|-37.66805332|Bureta Superette|
      |176.1401627|-37.66831727|Cherrywood Lotto & Book Shop|
      |176.154427|-37.669038|Countdown Bureta Park|
      |176.145242|-37.720965|Peter Pan Superette|
      |176.122809|-37.742492|Pyes Pa Supervalue|
      |176.0252365|-37.68115413|Whakamarama General Store|
      |176.1577105|-37.7004339|Countdown Tauranga|
      |176.1330783|-37.72576314|Greerton Lotto|
      |176.157894|-37.700255|Mags, Cards & Lotto|
      |176.165009|-37.710915|Z 15th Ave|
      |176.10378|-37.738292|Pak N Save Tauriko|
      |176.0734764|-37.6953627|Te Puna Four Square|
      |176.1826887|-37.72485154|Welcome Bay Foodmarket|
      |176.191729|-37.725397|Welcome Bay Four Square|
      |167.7150765|-45.41471549|Fresh Choice Te Anau|
      |167.713461|-45.416771|Te Anau Four Square|
      |175.713294|-37.54383|Te Aroha Four Square|
      |175.7127145|-37.54397831|Te Aroha Supermarket|
      |175.3255989|-38.01207338|Countdown Te Awamutu|
      |175.3209058|-38.00923837|Fresh Choice Te Awamutu|
      |175.3283244|-38.010786|Movie HQ|
      |175.3400236|-38.00760776|Pak n Save Te Awamutu|
      |175.3263082|-38.00959301|Paper Plus Te Awamutu|
      |175.344905|-38.037728|Kihikihi Bookshop|
      |174.9184859|-38.05377002|Oparau Roadhouse|
      |175.1429947|-37.40455852|Te Kauwhata Foodmarket|
      |175.162316|-38.331677|New World Te Kuiti|
      |175.1658795|-38.3350324|Paper Plus Te Kuiti|
      |175.164151|-38.333560|Supervalue Te Kuiti|
      |176.325349|-37.78397229|Te Puke Four Square|
      |176.3279416|-37.78597754|Te Puke New World|
      |176.329488|-37.78562296|Te Puke United Video & Lotto|
      |176.3306589|-37.78526005|Z Te Puke|
      |176.4119726|-37.82212765|Paengaroa Country Store|
      |171.27662|-44.24103284|Temuka New World|
      |171.2774426|-44.24438249|Village Post Temuka|
      |175.5440809|-37.14271947|Martina Four Square & Lotto|
      |175.539342|-37.13932171|Pak N Save Thames|
      |175.5421836|-37.13880557|Paper Power Thames|
      |171.2530037|-44.39582831|Action Sports (NZ) Ltd|
      |171.2388619|-44.39605033|Countdown Church Street|
      |171.2540899|-44.40250579|Countdown Timaru|
      |171.2512033|-44.40848465|Park Night N Day|
      |171.2229625|-44.39022553|Timaru New World|
      |171.2388641|-44.38139295|Timaru Pak n Save|
      |171.252039|-44.394705|Whitcoulls Timaru|
      |171.247681|-44.393677|Z Caroline Bay|
      |171.2103743|-44.38534866|Morgans Road Four Square|
      |171.240679|-44.400746|Timaru Discounter|
      |171.238488|-44.357384|Caltex Washdyke|
      |175.7571633|-37.97772642|Caltex Tirau|
      |178.3149906|-38.13034442|Tokomaru Bay Four Square|
      |175.868294|-38.236138|Balmoral Four Square|
      |175.873812|-38.222283|Countdown Tokoroa|
      |175.8674406|-38.21942118|Flickers|
      |175.8668584|-38.23130523|Kelso Street Pricecutter|
      |175.867334|-38.21909221|New World Tokoroa|
      |175.8725771|-38.2176044|Paper Plus Tokoroa|
      |178.2963554|-38.37072625|John's Superette & Lotto|
      |174.9426936|-37.26779391|Tuakau Food Market|
      |174.9469568|-37.2572734|Tuakau Supervalue|
      |167.689050|-46.135207|Tuatapere Four Square|
      |175808748|-38989871|BP 2 Go Ridley Motors|
      |175.8110181|-38.99029421|Turangi New World|
      |175.809789|-38.99069165|Z Turangi|
      |170.099108|-44.257134|MacKenzie Four Square|
      |170.0980567|-44.25704027|Mackenzie Lotto Plus|
      |175.0605622|-41.12530674|Caltex Upper Hutt|
      |175.0720565|-41.12522129|Countdown Maidstone|
      |175.0706828|-41.12309024|Countdown Upper Hutt|
      |175.0662231|-41.12378751|Pak N Save Upper Hutt|
      |175.0738442|-41.12400642|Paper Plus Upper Hutt|
      |175.0974485|-41.10882707|Caltex Rimutaka|
      |175.011799|-41.148502|New World Silverstream|
      |175.0118795|-41.14748305|Silverstream Pharmacy Ltd|
      |175.0818701|-41.11029441|Totara Park Four Square|
      |175.033934|-41.137761|Trentham Mini Mart|
      |175.75255|-37.759087|N M Superette|
      |175.0098963|-36.78259857|Oneroa Four Square|
      |175.045351|-36.796170|Countdown Waiheke|
      |175.0465422|-36.79602646|Ostend Store|
      |175.8394688|-37.39317669|New World Waihi|
      |175.8405525|-37.39133744|Paper Plus Waihi & Toyworld|
      |175.9423533|-37.41170973|Waihi Beach Four Square|
      |175.0648795|-40.87760065|The Bookshelf|
      |175.0654612|-40.87507577|Waikanae New World|
      |175.0247467|-40.86127637|Waikanae Beach Four Square|
      |171.0471917|-44.73371695|Waimate New World|
      |174.492747|-36.768466|Waimauku Minimart|
      |174.4932863|-36.76829123|Fresh Choice Waimauku|
      |174.9479106|-41.2421782|Norfolk Street Foodmarket|
      |175.675115|-39.471968|Waiouru Four Square|
      |175.669145|-39.479322|Z Waiouru|
      |173.9169046|-35.20742869|Waipapa Dairy|
      |176.5862345|-39.94539226|BP Waipawa|
      |176.5870384|-39.94381037|Waipawa Four Square|
      |174.445058|-35.984438|Waipu Lotto & Post|
      |176.5571749|-39.994737|Caltex Waipukurau|
      |176.557567|-39.995632|Countdown Waipukurau|
      |176.5562368|-39.99450039|New World Waipukurau|
      |176.5548819|-39.99543132|Paper Plus Waipukurau|
      |177.418911|-39.03326163|Johansen's Lotto|
      |177.419006|-39.02961823|Mobil Wairoa|
      |177.4179304|-39.03397547|New World Wairoa|
      |177.418154|-39.03546|Z Wairoa|
      |174.2386247|-39.00085022|Keyman Video & Lotto|
      |174.236716|-39.000243|New World Waitara|
      |174.2361077|-39.00210382|Waitara Post & Lotto|
      |174.7285557|-37.25032872|New World Waiuku|
      |174.7300991|-37.24927256|Paper Plus Waiuku|
      |173.0428377|-41.40624067|Wakefield Four Square|
      |169.1353637|-44.69550869|Paper Plus Wanaka|
      |169.137315|-44.693691|Wanaka Four Square|
      |169.1350958|-44.69620126|Wanaka New World|
      |174.664539|-36.399271|Countdown Warkworth|
      |174.6639264|-36.39760685|Franklins Pharmacy|
      |174.6664777|-36.39845894|New World Warkworth|
      |174.7237089|-36.42029688|Mahurangi Four Square|
      |174.6293987|-39.76439522|G.A.S. Waverley|
      |174.634324|-39.763859|Waverley Four Square|
      |174.7799615|-41.2928695|Fix Courtenay Central|
      |174.7758817|-41.28674572|Fix Grand Arcade|
      |174.7800284|-41.2796557|Railway Metro New World|
      |174.770471|-41.296387|Shalimar Four Square|
      |174.7758054|-41.29289103|Unichem Cuba Mall|
      |174.7765455|-41.29212394|Whitcoulls Cuba Mall|
      |174.775332|-41.283203|Whitcoulls Lambton Quay|
      |174.7764922|-41.29717768|Z Taranaki St|
      |174.7785478|-41.28164189|Z Harbour City|
      |174.7638081|-41.3053815|Brooklyn Pharmacy|
      |174.8084005|-41.20276442|New World Churton Park|
      |174.765616|-41.257049|Countdown Crofton Downs|
      |174.933314|-41.211153|Yug Superstore|
      |174.7942967|-41.30423083|Hataitai Four Square|
      |174.773321|-41.334656|Island Bay Video|
      |174.772784|-41.334604|New World Island Bay|
      |174.807823|-41.224134|Countdown Johnsonville|
      |174.807007|-41.223791|Johnsonville Dairy|
      |174.7991312|-41.2280639|Nikisha Foodmarket|
      |174.8071434|-41.22280861|Paper Plus Johnsonville|
      |174.8047699|-41.2263444|Z Johnsonville|
      |174.7459498|-41.28248684|Karori Four Square|
      |174.7386113|-41.28439202|Paper Plus Select Karori|
      |174.7618589|-41.28900965|Kelburn Four Square|
      |174.7915662|-41.24750415|Khandallah New World|
      |174.7946939|-41.31949577|Countdown Kilbirnie|
      |174.7964636|-41.31823831|Pak N Save Kilbirnie|
      |174.7943063|-41.31920057|Paper Plus Kilbirnie|
      |174.763354|-41.323598|Kingston Foodmarket|
      |174.914085|-41.20406585|Z Vic Corner|
      |174.8674692|-41.09145809|Z Mana|
      |174.8162973|-41.31618168|Miramar Lotto and Gift Shop|
      |174.8145371|-41.31579917|Miramar New World|
      |174.8138763|-41.31501481|Z Miramar|
      |174.7792773|-41.30231219|Caltex Basin Reserve|
      |174.785481|-41.296610|Mount Victoria Food Market|
      |174.823147|-41.223417|New World Newlands|
      |174.777047|-41.307262|Countdown Newtown|
      |174.7800147|-41.3142952|Mall Books And Lotto|
      |174.7782171|-41.30748275|Newtown Four Square|
      |174.7750515|-41.24721549|Ngaio Supermart|
      |174.7573791|-41.28315483|Creswick Foodmarket|
      |174.795398|-41.291243|Oriental Bay Store|
      |174.817641|-41.213709|Paparangi Foodmarket|
      |174.847839|-41.138042|Z Mungavin Ave|
      |174.8114159|-41.32974115|Relay Wellington Airport|
      |174.812066|-41.329316|Relay - 103 Arrivals|
      |174.8206875|-41.32464743|Strathmore Foodmarket|
      |174.8104431|-41.32570849|Z Broadway|
      |174.8303|-41.185937|Countdown Tawa|
      |174.832239|-41.157286|Linden Foodmarket|
      |174.8249177|-41.17057818|Mac's Photo & Lotto|
      |174.82611|-41.169962|New World Tawa|
      |174.775228|-41.289638|Bev's Candy Bar and Lotto|
      |174.7822138|-41.29667167|Cambridge Terrace Lotto Shop|
      |174.7775461|-41.29146066|Citystop Manners Street|
      |174.780837|-41.293495|Fix Courtenay Place|
      |174.775924|-41.293213|Fix Cuba Mall|
      |174.775993|-41.290489|Fix Manners Mall|
      |174.778495|-41.29323|Kiwi Mart|
      |174.7745478|-41.29565968|S & S Patel Superette|
      |174.780244|-41.292757|Unichem Courtenay Place|
      |174.7838904|-41.2928721|Wellington City New World|
      |174.7744198|-41.29441446|Z Vivian Street|
      |174.7779719|-41.27593158|A & L Freeman's Bookshop|
      |174.7789436|-41.27860067|Freeman's Lotto & Newsagency|
      |174.768921|-41.278958|Thorndon General Store|
      |174.7788599|-41.2741707|Thorndon New World|
      |174.7778889|-41.28209811|Anita's Store|
      |174.7757147|-41.28109882|Kirby's Candies and Lotto|
      |174.775609|-41.287336|Kirby's Candies Spark Central|
      |174.775455|-41.280419|TJ Terrace Superette|
      |174.523487|-36.294975|Rodney Four Square|
      |174.5240323|-36.29294395|Woodys Winners|
      |171.6026175|-41.75949217|Countdown Westport|
      |171.5986611|-41.75514865|Dennis Bookshop|
      |171.5989043|-41.75745679|Westport New World|
      |176.9950524|-37.95612318|Countdown Whakatane|
      |176.9821686|-37.96112373|Halfway Store|
      |176.961479|-37.960650|Mananui Dairy|
      |176.9931534|-37.95064449|New World Whakatane|
      |176.9823382|-37.96088955|Pak N Save Whakatane|
      |176.995565|-37.95159778|Paper Plus Whakatane|
      |176.9825176|-37.95874128|Z Whakatane|
      |176.890168|-37.99875672|Awakeri Store|
      |176.7586291|-37.88860029|Matata Superfoods|
      |176.796797|-38.036215|Te Teko Supa Market|
      |175.8678112|-37.2019909|New World Whangamata|
      |175.8720571|-37.2059754|Whanga Books|
      |175.0389633|-39.9254512|Countdown Victoria Ave|
      |175.0409966|-39.92614948|New World Whanganui|
      |175.0388406|-39.92634432|Pak N Save Whanganui|
      |175.0537594|-39.9360814|Trafalgar Lotto|
      |175.0509541|-39.93247959|Whitcoulls Whanganui|
      |175.049515|-39.92152|Z Dublin Street|
      |175.0545711|-39.9095433|Aramoho Mags & Lotto|
      |174.9931307|-39.94281005|Castlecliff Four Square|
      |175.059843|-39.933869|Riverview Four Square|
      |175.0226896|-39.94317289|Whanganui Supervalue|
      |175.021819|-39.931773|Unichem Whanganui|
      |175.0381636|-39.91833195|St Johns Four Square|
      |175.059511|-39.9177157|Lindsay's Lotto Post & More|
      |174.7483643|-36.63660457|Countdown Whangaparaoa|
      |174.7924952|-36.61410269|Gulf Harbour Foodmarket|
      |174.7491728|-36.63716015|Joyce Superette|
      |174.763523|-36.631477|Manly Pricecutter|
      |174.732150|-36.628494|New World Whangaparaoa|
      |174.740523|-36.635935|Rishworth Superette|
      |174.740187|-36.626839|Stanmore Bay Superette|
      |174.7393619|-36.6344527|Z Whangaparaoa|
      |174.3120658|-35.73075361|Corner Cardz N Magz|
      |174.3266533|-35.72998245|Countdown Whangarei|
      |174.3205552|-35.7256097|Paper Plus Whangarei|
      |174.324474|-35.72541132|Whangarei Pak N Save|
      |174.3012053|-35.68353993|Kamo Lotto|
      |174.3099717|-35.67771773|Sunnyside Foodmarket|
      |174.3016494|-35.6842237|Z Kamo|
      |174.3178165|-35.704493|Patels Foodmarket|
      |174.282722|-35.73949375|Tui Crescent Foodmarket|
      |174.3200341|-35.73439669|The Korna Store|
      |174.3683659|-35.75559995|Onerahi Bookshop & Lotto|
      |174.5041384|-35.62969353|Ngunguru Food Mart|
      |174.456783|-35.76944035|Parua Bay Four Square|
      |174.3079957|-35.74288044|Otaika Lotto & Post|
      |174.322232|-35.714443|Countdown Regent|
      |174.3223488|-35.71623561|New World Regent|
      |174.326689|-35.6862471|Countdown Tikipunga|
      |174.3317398|-35.68438051|Meadow Park Store|
      |174.312487|-35.698666|Whau Valley Dairy|
      |175.69396|-36.833865|Countdown Whitianga|
      |175.7042149|-36.83592248|Paper Plus Whitianga|
      |175.7016195|-36.83301533|Whitianga New World|
      |175.6614635|-36.73283584|Matarangi Beach General Store|
      |168.3249013|-46.14246016|Paper Plus Winton|
      |168.3254695|-46.14156949|Winton New World|
      |172.6652255|-43.32329734|Woodend Store|
      |175.8644581|-40.33645488|Caltex Woodville|
      |168.8485783|-46.3288483|Wyndham Four Square|