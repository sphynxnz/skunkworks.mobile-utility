@baseUrl @baseUrl-mobileutility @wsdl @wsdl-mule_mobutil
Feature: Ticket checker examples
  The following are test scenarios againts the ESI ticket validation mock service

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
    When I check the ticket
    Then The soap response property "response.Status" should be "success"
    And The soap response property "validationResult.resultType" should be "WINNER"
    And The soap response property "validationResult.resultCode" should be "1207"

  Scenario: IK TICKET - INVALID_TICKET_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9430016273991111",
      "checkDigits": "1111",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I check the ticket
    Then The soap response property "response.Status" should be "success"
    And The soap response property "validationResult.resultType" should be "OTHER"
    And The soap response property "validationResult.resultCode" should be "9001"

  Scenario: IK TICKET - INVALID_TICKET_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9430016273992222",
      "checkDigits": "2222",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I check the ticket
    Then The soap response property "response.Status" should be "success"
    And The soap response property "validationResult.resultType" should be "OTHER"
    And The soap response property "validationResult.resultCode" should be "9001"

  Scenario: IK TICKET - INVALID_TICKET_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9430016273993333",
      "checkDigits": "3333",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I check the ticket
    Then The soap response property "response.Status" should be "success"
    And The soap response property "validationResult.resultType" should be "OTHER"
    And The soap response property "validationResult.resultCode" should be "9001"

  Scenario: IK TICKET - INVALID_TICKET_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9430016273994444",
      "checkDigits": "4444",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I check the ticket
    Then The soap response property "response.Status" should be "success"
    And The soap response property "validationResult.resultType" should be "OTHER"
    And The soap response property "validationResult.resultCode" should be "9001"

  Scenario: IK TICKET - INVALID_TICKET_NUMBER
    Given The json request data
    """json
    {
      "serialNumber": "9430016273995555",
      "checkDigits": "5555",
      "channelId": 1,
      "format": "1",
      "source": "192.168.100.100",
      "deviceId": "AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE",
      "emailAddress": "userid08@dummy.co.nz"
    }    
    """
    When I check the ticket
    Then The soap response property "response.Status" should be "success"
    And The soap response property "validationResult.resultType" should be "OTHER"
    And The soap response property "validationResult.resultCode" should be "9001"

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
    When I check the ticket
    Then The soap response property "response.Status" should be "success"
    And The soap response property "validationResult.resultType" should be "OTHER"
    And The soap response property "validationResult.resultCode" should be "9001"