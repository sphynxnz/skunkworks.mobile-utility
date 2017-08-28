@baseUrl @baseUrl-mobileutility
Feature: Ticket checker examples
  The following are test scenarios againts the ESI ticket validation mock service

#------------------------
# ONLINE TICKET SCENARIOS
#------------------------


  Scenario: OL TICKET - TICKET_ON_HOLD
    Given The json request data
    """json
    {
      "serialNumber": "0660089034281259",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3101"

  Scenario: OL TICKET - NOT_WINNING_TICKET
    Given The json request data
    """json
    {
      "serialNumber": "0660177579522026",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "LOSER"
    And The response property "validationResult.resultCode" should be "2101"

  Scenario: OL TICKET - PRIOR_DRAW
    Given The json request data
    """json
    {
      "serialNumber": "0660036605441264",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3102"

  Scenario: OL TICKET - TICKET_CANCELLED
    Given The json request data
    """json
    {
      "serialNumber": "0660345710082082",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3103"

  Scenario: OL TICKET - NEED_CONFIRMATION>
    Given The json request data
    """json
    {
      "serialNumber": "0660423697961229",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3104"

  Scenario: OL TICKET - PAID_ALREADY
    Given The json request data
    """json
    {
      "serialNumber": "0660100391042004",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"   
    And The response property "validationResult.resultCode" should be "3105"

  Scenario: OL TICKET - COMPLETELY_EXPIRED
    Given The json request data
    """json
    {
      "serialNumber": "0660539153921201",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3106"

  Scenario: OL TICKET - AMOUNT_TOO_LARGE_SMALL
    Given The json request data
    """json
    {
      "serialNumber": "0660432217652064",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1101"

  Scenario: OL TICKET - NOT_ABLE_TO_PAY
    Given The json request data
    """json
    {
      "serialNumber": "0660358817292008",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1102"

  Scenario: OL TICKET - ALREADY_CLAIMED
    Given The json request data
    """json
    {
      "serialNumber": "0660096898612083",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3107"

  Scenario: OL TICKET - REJECTED_CALL_HOTLINE
    Given The json request data
    """json
    {
      "serialNumber": "0660023498252027",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3108"

  Scenario: OL TICKET - PAYMENT_DEFERRED
    Given The json request data
    """json
    {
      "serialNumber": "0660073303052574",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3109"

  Scenario: OL TICKET - ALREADY_CLAIMED
    Given The json request data
    """json
    {
      "serialNumber": "0660371269121333",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3107"

  Scenario: OL TICKET - TERMINAL_IN_TRAINING_MODE
    Given The json request data
    """json
    {
      "serialNumber": "0660431562292053",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3111"

  Scenario: OL TICKET - PRIZE_EXCEEDED
    Given The json request data
    """json
    {
      "serialNumber": "0660358161932094",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1103"

  Scenario: OL TICKET - TICKET_TOO_OLD
    Given The json request data
    """json
    {
      "serialNumber": "0660256222761281",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3112"

  Scenario: OL TICKET - EXPIRED
    Given The json request data
    """json
    {
      "serialNumber": "0660022842892016",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3113"

  Scenario: OL TICKET - DRAW_NOT_CLOSED
    Given The json request data
    """json
    {
      "serialNumber": "0660607308852542",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3114"

  Scenario: OL TICKET - VALIDATE_MANUALLY
    Given The json request data
    """json
    {
      "serialNumber": "0660533908492583",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3115"

  Scenario: OL TICKET - HIGH_TIER_WINNER
    Given The json request data
    """json
    {
      "serialNumber": "0660271948852530",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1104"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"

  Scenario: OL TICKET - MID_TIER_WINNER
    Given The json request data
    """json
    {
      "serialNumber": "0660088378921347",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1105"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"

  Scenario: OL TICKET - HIGH_WITH_NO_EXCHANGE
    Given The json request data
    """json
    {
      "serialNumber": "0660424353321339",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1106"

  Scenario: OL TICKET - REJECTED_FREE_TICKETS_STILL
    Given The json request data
    """json
    {
      "serialNumber": "0660371924481344",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1107"

  Scenario: OL TICKET - DEVICE_UNABLE_TO_PAY
    Given The json request data
    """json
    {
      "serialNumber": "0660089034261358",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1108"

  Scenario: OL TICKET - FUNCTION_SUPRESSED
    Given The json request data
    """json
    {
      "serialNumber": "1170283747842001",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3247"

  Scenario: OL TICKET - DIVISION_WINNER
    Given The json request data
    """json
    {
      "serialNumber": "0660670881322058",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1109"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"    

  Scenario: OL TICKET - DIVISION_WINNER
    Given The json request data
    """json
    {
      "serialNumber": "0500610572852045",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1109"

  Scenario: OL TICKET - WINNING_CASH_BONUS
    Given The json request data
    """json
    {
      "serialNumber": "0660555537922074",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1110"

  Scenario: OL TICKET - NOT_WINNING_MULTIDRAW
    Given The json request data
    """json
    {
      "serialNumber": "0660335521322046",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "LOSER"
    And The response property "validationResult.resultCode" should be "2102"

  Scenario: OL TICKET - WINNING_ALREADY_PAID
    Given The json request data
    """json
    {
      "serialNumber": "0660220177922062",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1111"

  Scenario: OL TICKET - PLEASE_SEE_RETAILER
    Given The json request data
    """json
    {
      "serialNumber": "0660670225962047",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3116"

  Scenario: OL TICKET - WINNING_MAJOR
    Given The json request data
    """json
    {
      "serialNumber": "0660554882562063",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1112"

  Scenario: OL TICKET - WINNING_MAJOR
    Given The json request data
    """json
    {
      "serialNumber": "0500552906251283",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1112"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"        

  Scenario: OL TICKET - WINNING_FREE_TICKET
    Given The json request data
    """json
    {
      "serialNumber": "0660607964212553",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1113"

  Scenario: OL TICKET - VALIDATION_OK
    Given The json request data
    """json
    {
      "serialNumber": "0660534563852594",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3118"

  Scenario: OL TICKET - INVALID_TICKET_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "0660334865962035",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "9001"

  Scenario: OL TICKET - HIGH_TIER_WINNER
    Given The json request data
    """json
    {
      "serialNumber": "0660271948852530",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1104"

  Scenario: OL TICKET - ERROR_NOT_WINNER
    Given The json request data
    """json
    {
      "serialNumber": "0660562744331394",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "LOSER"
    And The response property "validationResult.resultCode" should be "2103"

  Scenario: OL TICKET - PAID_BY_EFT
    Given The json request data
    """json
    {
      "serialNumber": "0660051678722018",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3117"

  Scenario: OL TICKET - PAID_BY_EFT - Using SoapUI mock, simulates timeout
    Given The json request data
    """json
    {
      "serialNumber": "0500626298931317",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "failure"
    And The response property "response.code" should be "7000"

  Scenario: OL TICKET - MISSING_SCENARIO
    Given The json request data
    """json
    {
      "serialNumber": "0660334865962099",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "failure"
    And The response property "response.code" should be "8001"

#------------------------
# IK TICKET SCENARIOS
#------------------------



  Scenario: IK TICKET - Host Response 1
    Given The json request data
    """json
    {
      "serialNumber": "9891420700187937509924",
      "checkDigits": "9924",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1201"

  Scenario: IK TICKET - Host Response 2
    Given The json request data
    """json
    {
      "serialNumber": "9891420700229002409815",
      "checkDigits": "9815",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "1202"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"    

  Scenario: IK TICKET - Host Response 3
    Given The json request data
    """json
    {
      "serialNumber": "9891420700322291700780",
      "checkDigits": "0780",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "LOSER"
    And The response property "validationResult.resultCode" should be "2201"

  Scenario: IK TICKET - Host Response 4
    Given The json request data
    """json
    {
      "serialNumber": "9891420700442424501859",
      "checkDigits": "1859",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1203"

  Scenario: IK TICKET - Host Response 5
    Given The json request data
    """json
    {
      "serialNumber": "9891420700576905905689",
      "checkDigits": "5689",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1204"

  Scenario: IK TICKET - Host Response 6
    Given The json request data
    """json
    {
      "serialNumber": "9891420700608165400118",
      "checkDigits": "0118",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1205"

  Scenario: IK TICKET - Host Response 7
    Given The json request data
    """json
    {
      "serialNumber": "9891420700793273209906",
      "checkDigits": "9906",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    # ==> Changed to OTHER from WINNER
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1206"

  Scenario: IK TICKET - Host Response 16
    Given The json request data
    """json
    {
      "serialNumber": "9891420700894098204143",
      "checkDigits": "4143",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3201"

  Scenario: IK TICKET - Host Response 17
    Given The json request data
    """json
    {
      "serialNumber": "9891420700920101400090",
      "checkDigits": "0090",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3202"

  Scenario: IK TICKET - Host response 18
    Given The json request data
    """json
    {
      "serialNumber": "9891420701031841204610",
      "checkDigits": "4610",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3203"

  Scenario: IK TICKET - Host Response 19
    Given The json request data
    """json
    {
      "serialNumber": "9891420701127098302337",
      "checkDigits": "2337",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3204"

  Scenario: IK TICKET - Host Response 20
    Given The json request data
    """json
    {
      "serialNumber": "9891420701251118606056",
      "checkDigits": "6056",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3205"

  Scenario: IK TICKET - Host Response 21
    Given The json request data
    """json
    {
      "serialNumber": "9891420701344467106945",
      "checkDigits": "6945",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3206"

  Scenario: IK TICKET - Host Response 22
    Given The json request data
    """json
    {
      "serialNumber": "9891420701430391603248",
      "checkDigits": "3248",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3207"

  Scenario: IK TICKET - Host Response 23
    Given The json request data
    """json
    {
      "serialNumber": "9891420701517020802241",
      "checkDigits": "2241",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3208"

  Scenario: IK TICKET - Host Response 24
    Given The json request data
    """json
    {
      "serialNumber": "9891420701695194909734",
      "checkDigits": "9734",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3209"

  Scenario: IK TICKET - Host response 25
    Given The json request data
    """json
    {
      "serialNumber": "9891420701764109705177",
      "checkDigits": "5177",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3210"

  Scenario: IK TICKET - Host Response 32
    Given The json request data
    """json
    {
      "serialNumber": "9891420701811088009649",
      "checkDigits": "9649",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "1207"

  Scenario: IK TICKET - Host Response 33
    Given The json request data
    """json
    {
      "serialNumber": "9891420701945593409592",
      "checkDigits": "9592",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3211"

  Scenario: IK TICKET - Host Response 34
    Given The json request data
    """json
    {
      "serialNumber": "9891420702033290403334",
      "checkDigits": "3334",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3212"

  Scenario: IK TICKET - Host Response 35
    Given The json request data
    """json
    {
      "serialNumber": "9891420702189626307580",
      "checkDigits": "7580",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3210"

  Scenario: IK TICKET - Host Response 36
    Given The json request data
    """json
    {
      "serialNumber": "9891420702232381500786",
      "checkDigits": "0786",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3214"

  Scenario: IK TICKET - Host Response 41
    Given The json request data
    """json
    {
      "serialNumber": "9891420702410853508724",
      "checkDigits": "8724",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3216"

  Scenario: IK TICKET - Host Response 42
    Given The json request data
    """json
    {
      "serialNumber": "9891420702560198406065",
      "checkDigits": "6065",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3217"

  Scenario: IK TICKET - Host Response 42
    Given The json request data
    """json
    {
      "serialNumber": "9891420704914830707289",
      "checkDigits": "7289",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3239"

  Scenario: IK TICKET - Free Ticket Winner
    Given The json request data
    """json
    {
      "serialNumber": "9891420702694435600051",
      "checkDigits": "0051",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "3242"

  Scenario: IK TICKET - Free Ticket Winner
    Given The json request data
    """json
    {
      "serialNumber": "9891419800298350004675",
      "checkDigits": "4675",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "3242"

  Scenario: IK TICKET - Free Ticket Winner
    Given The json request data
    """json
    {
      "serialNumber": "9971000100218322300477",
      "checkDigits": "0477",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "3242"

  Scenario: IK TICKET - Free Ticket Winner
    Given The json request data
    """json
    {
      "serialNumber": "9971000200128526807891",
      "checkDigits": "7891",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    # ==> Changed to 1201 from 3242
    And The response property "validationResult.resultCode" should be "1201"

  Scenario: IK TICKET - Free Ticket Winner
    Given The json request data
    """json
    {
      "serialNumber": "9971000100135167508506",
      "checkDigits": "8506",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    # ==> Changed to 1201 from 3242
    And The response property "validationResult.resultCode" should be "1201"

  Scenario: IK TICKET - BAD_UNIT_CHECK_DIGIT
    Given The json request data
    """json
    {
      "serialNumber": "9891420704811979306805",
      "checkDigits": "6805",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "9001"

  Scenario: IK TICKET - Stolen Pack Status
    Given The json request data
    """json
    {
      "serialNumber": "9891419800145779204331",
      "checkDigits": "4331",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3240"

  Scenario: IK TICKET - Invalid Pack Status
    Given The json request data
    """json
    {
      "serialNumber": "9891420702726941701693",
      "checkDigits": "1693",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3244"

  Scenario: IK TICKET - FREEZE_CLAIM
    Given The json request data
    """json
    {
      "serialNumber": "9971000200287882201466",
      "checkDigits": "1466",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "3245"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"

  Scenario: IK TICKET - FREEZE_CLAIM
    Given The json request data
    """json
    {
      "serialNumber": "9971000100399126400124",
      "checkDigits": "0124",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "3245"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"

  Scenario: IK TICKET - FREEZE_CLAIM
    Given The json request data
    """json
    {
      "serialNumber": "9971000200301183409919",
      "checkDigits": "9919",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "3245"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"

  Scenario: IK TICKET - FILE_CLAIM
    Given The json request data
    """json
    {
      "serialNumber": "9971000100460621600141",
      "checkDigits": "0141",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "WINNER"
    And The response property "validationResult.resultCode" should be "3248"
    And The response property "validationResult.majorPrizeMessage" should be "A MAJOR PRIZE"

########
#  Scenario: IK TICKET - BAD_UNIT_CHECK_DIGIT
#    Given The json request data
#    """json
#    {
#      "serialNumber": "9430016273991111111111",
#      "checkDigits": "1111",
#      "channelId": 1,
#      "format": "1",
#      "source": "192.168.100.100",
#      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
#      "emailAddress": "userid08@dummy.co.nz"
#    }    
#    """
#    When I make a POST request to "/validations"
#    Then The response property "response.status" should be "success"
#    And The response property "validationResult.resultType" should be "OTHER"
#    And The response property "validationResult.resultCode" should be "9001"

#  Scenario: IK TICKET - BAD_UNIT_CHECK_DIGIT
#    Given The json request data
#    """json
#    {
#      "serialNumber": "9430016273992222222222",
#      "checkDigits": "2222",
#      "channelId": 1,
#      "format": "1",
#      "source": "192.168.100.100",
#      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
#      "emailAddress": "userid08@dummy.co.nz"
#    }    
#    """
#    When I make a POST request to "/validations"
#    Then The response property "response.status" should be "success"
#    And The response property "validationResult.resultType" should be "OTHER"
#    And The response property "validationResult.resultCode" should be "9001"

#  Scenario: IK TICKET - BAD_UNIT_CHECK_DIGIT
#    Given The json request data
#    """json
#    {
#      "serialNumber": "9430016273993333333333",
#      "checkDigits": "3333",
#      "channelId": 1,
#      "format": "1",
#      "source": "192.168.100.100",
#      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
#      "emailAddress": "userid08@dummy.co.nz"
#    }    
#    """
#    When I make a POST request to "/validations"
#    Then The response property "response.status" should be "success"
#    And The response property "validationResult.resultType" should be "OTHER"
#    And The response property "validationResult.resultCode" should be "9001"

#  Scenario: IK TICKET - BAD_UNIT_CHECK_DIGIT
#    Given The json request data
#    """json
#    {
#      "serialNumber": "9430016273994444444444",
#      "checkDigits": "4444",
#      "channelId": 1,
#      "format": "1",
#      "source": "192.168.100.100",
#      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
#      "emailAddress": "userid08@dummy.co.nz"
#    }    
#    """
#    When I make a POST request to "/validations"
#    Then The response property "response.status" should be "success"
#    And The response property "validationResult.resultType" should be "OTHER"
#    And The response property "validationResult.resultCode" should be "9001"

#  Scenario: IK TICKET - INVALID_TICKET_NUMBER
#    Given The json request data
#    """json
#    {
#      "serialNumber": "9430016273995555555555",
#      "checkDigits": "5555",
#      "channelId": 1,
#      "format": "1",
#      "source": "192.168.100.100",
#      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
#      "emailAddress": "userid08@dummy.co.nz"
#    }    
#    """
#    When I make a POST request to "/validations"
#    Then The response property "response.status" should be "success"
#    And The response property "validationResult.resultType" should be "OTHER"
#    And The response property "validationResult.resultCode" should be "9001"

  Scenario: IK TICKET - FUNCTION_SUPRESSED
    Given The json request data
    """json
    {
      "serialNumber": "9891420702889747900451",
      "checkDigits": "0451",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3218"

  Scenario: IK TICKET - NOT_ALLOWED_THIS_FUNCTION
    Given The json request data
    """json
    {
      "serialNumber": "9891420702985434407609",
      "checkDigits": "7609",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3219"

  Scenario: IK TICKET - BAD_PASS_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9891420703042003803563",
      "checkDigits": "3563",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3220"

  Scenario: IK TICKET - INCORRECT_TERM_AGENT
    Given The json request data
    """json
    {
      "serialNumber": "9891420703137793402907",
      "checkDigits": "2907",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3221"

  Scenario: IK TICKET - INVALID_ATTEMPT
    Given The json request data
    """json
    {
      "serialNumber": "9891420703258778409238",
      "checkDigits": "9238",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3222"

  Scenario: IK TICKET - DB_TRANSACTION_FAILURE
    Given The json request data
    """json
    {
      "serialNumber": "9891420703394656202867",
      "checkDigits": "2867",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3223"

  Scenario: IK TICKET - LOCATION_CHANGE_NOT_ALLOWED
    Given The json request data
    """json
    {
      "serialNumber": "9891420703400324702756",
      "checkDigits": "2756",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3224"

  Scenario: IK TICKET - UNIT_NOT_AT_LOCATION
    Given The json request data
    """json
    {
      "serialNumber": "9891420703524221700247",
      "checkDigits": "0247",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3225"

  Scenario: IK TICKET - INVALID_LOCATION_TRANSFER
    Given The json request data
    """json
    {
      "serialNumber": "9891420703648373806222",
      "checkDigits": "6222",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3226"

  Scenario: IK TICKET - NOT_ENOUGH_INVENTORY_AVAILABLE
    Given The json request data
    """json
    {
      "serialNumber": "9891420703794396107128",
      "checkDigits": "7128",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3227"

  Scenario: IK TICKET - DESTINATION_LOC_NOT_ACTIVE
    Given The json request data
    """json
    {
      "serialNumber": "9891420703821044009361",
      "checkDigits": "9361",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3228"

  Scenario: IK TICKET - FROM_LOC_NOT_ACTIVE
    Given The json request data
    """json
    {
      "serialNumber": "9891420703976627308157",
      "checkDigits": "8157",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3229"

  Scenario: IK TICKET - SPLITS_NOT_ALLOWED
    Given The json request data
    """json
    {
      "serialNumber": "9891420704051499901980",
      "checkDigits": "1980",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3230"

  Scenario: IK TICKET - INVALID_TEST_CONDITION_FOR_TRANS
    Given The json request data
    """json
    {
      "serialNumber": "9891420704185349505669",
      "checkDigits": "5669",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3231"

  Scenario: IK TICKET - INVALID_SIDE_EFFECT_FOR_TRANS
    Given The json request data
    """json
    {
      "serialNumber": "9891420704269985008156",
      "checkDigits": "8156",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3232"

  Scenario: IK TICKET - NO_UNITS_FOUND
    Given The json request data
    """json
    {
      "serialNumber": "9891420704393507209560",
      "checkDigits": "9560",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3233"

  Scenario: IK TICKET - NO_AVAILABLE_UNITS
    Given The json request data
    """json
    {
      "serialNumber": "9891420704499441307888",
      "checkDigits": "7888",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3234"

  Scenario: IK TICKET - INVALID_REFERENCE_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9891420704559427208568",
      "checkDigits": "8568",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3235"

  Scenario: IK TICKET - MESSES_TO_IDIS_FAILED
    Given The json request data
    """json
    {
      "serialNumber": "9891420704673137406891",
      "checkDigits": "6891",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3236"

  Scenario: IK TICKET - INVALID_PRODUCT_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9891420704735802609219",
      "checkDigits": "9219",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3237"

  Scenario: IK TICKET - GAME_NOT_ACTIVE
    Given The json request data
    """json
    {
      "serialNumber": "9891420704914830707289",
      "checkDigits": "7289",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3239"

  Scenario: IK TICKET - INVALID_ATTEMPT
    Given The json request data
    """json
    {
      "serialNumber": "9891420705096601100694",
      "checkDigits": "0694",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3222"

  Scenario: IK TICKET - PACK_ALREADY_HAS_STATUS
    Given The json request data
    """json
    {
      "serialNumber": "9891420705113164804969",
      "checkDigits": "4969",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "success"
    And The response property "validationResult.resultType" should be "OTHER"
    And The response property "validationResult.resultCode" should be "3241"

  Scenario: IK TICKET - MISSING_SCENARIO
    Given The json request data
    """json
    {
      "serialNumber": "9430016273912345671234",
      "checkDigits": "1234",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I make a POST request to "/validations"
    Then The response property "response.status" should be "failure"
    And The response property "response.code" should be "8001"    