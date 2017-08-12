@baseUrl @baseUrl-mobileutility
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