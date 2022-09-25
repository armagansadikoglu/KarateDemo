Feature: Reqres POST Demo
  # scenariolardan önce çalışacak adımlar Background'un içine yazılır
  Background:
    # baseURL değişkeni karate-config.js dosyasının içindeki var config bloğunun içinde tanımlı
    Given url baseURL

  Scenario: Reqres create user
    # header
    Given header accept = "application/json"
    # isteğin atılacağı endpoint path ile veriliyor
    And path "/users"
    # request değişkeni ile request body set edilir.Aşağıdaki gibi tek satırda verilebilir
    And request {"name": "morpheus","job": "leader"}
    # veya dosya üzerinden okunarak verilebilir
    And def requestBody = read('classpath:reqres/jsons/createRequestBody.json')
    And request requestBody
    # method ile isteğin hangi method kullanılarak atılacağı belirtilir
    When method post
    # status ile istekten dönecek status code assertionı yapılır
    Then status 201
    # requestBody değişkenini assertion için kullanabiliriz
    Then match response.name == requestBody.name
    Then match response.job == requestBody.job
    Then match response.id == '#notnull'
    Then match response.createdAt == '#string'


    # Scenario outline ve examples kullanımı ile aynı testi farklı datalarla da yapabilirz

    Scenario Outline:
      # header
      Given header accept = "application/json"
    # isteğin atılacağı endpoint path ile veriliyor
      And path "/users"
    # Dosya üzerinden request body'yi okuyup set komutu ile examplesdan gelen değerlerle güncelleyebiliriz
      And def requestBody = read('classpath:reqres/jsons/createRequestBody.json')
      And request requestBody
      And set requestBody.name = '<name>'
      And set requestBody.job = '<job>'
    # method ile isteğin hangi method kullanılarak atılacağı belirtilir
      When method post
    # status ile istekten dönecek status code assertionı yapılır
      Then status 201
    # requestBody değişkenini assertion için kullanabiliriz
      Then match response.name == requestBody.name
      Then match response.job == requestBody.job
      Then match response.id == '#notnull'
      Then match response.createdAt == '#string'
      Examples:
      |name   |job      |
      |Ali    |Developer|
      |Veli   |Analyst  |
      |Ayse   |Manager  |
      |Fatma  |Tester   |