Feature: Reqres GET Demo
  # scenariolardan önce çalışacak adımlar Background'un içine yazılır
  Background:
    # baseURL değişkeni karate-config.js dosyasının içindeki var config bloğunun içinde tanımlı
    Given url baseURL

  Scenario: Reqres list users
    # header
    Given header accept = "application/json"
    # page=2 parametresi
    And param page = 2
    # isteğin atılacağı endpoint path ile veriliyor
    And path "/users"
    # method ile isteğin hangi method kullanılarak atılacağı belirtilir
    When method get
    # status ile istekten dönecek status code assertionı yapılır
    Then status 200
    # assertionlardan önce match kelimesi kullanılır
    # response değişkeni karate tarafından tanımlanmış bir değişken, direkt kullanılır
    # response. ile kontrolü yapılacak field yazılır ve == ile beklenen değer yazılır
    # bu örnekte responsedaki body kısmında page'in 2 olması beklenir
    And match response.page == 2
    # data field'ının bir array olup olmadığının kontrolü
    And match response.data == '#[]'
    # data field'ın size'ı 6 olan bir array olup olmadığının kontrolü. Bu örnekte gerçekten de 6
    And match response.data == '#[6]'
    # per_page field'ı da 6'ya eşit. Bu değerle array size'ı eşit mi kontrolü
    # bu değeri tutmak için değişken tanımlanır. değişken tanımlama kuralı def degiskenAdi = deger
    And def perPage = response.per_page
    # data'nın perPage size'lı bir array olup olmadığının kontrolü
    And match response.data == '#[perPage]'
    # data'nın içindeki ilk kişinin first_name'inin Michael olup olmadığının kontrolü
    And match response.data[0].first_name == "Michael"
    # first_name'in data arrayinde kaçıncı sırada olduğuna bakılmaksızın kontrol
    # burada contains kullanılır çünkü liste dönüyor
    And match response.data[*].first_name contains "Michael"
    # first_name'in nerede olduğuna bile bakılmaksızın kontrol etmek için .. kullanılır
    And match response..first_name contains "Michael"
    # Schema kontrolü üç tırnak içinde json schema koyularak yapılabilir
    # #number #string #boolean #array gibi değerler kullanılır. Eğer boş gelmesi de ok ise önlerine bir tane daha # koyulur
    * match response ==
    """
    {
    "page": #number,
    "per_page": #number,
    "total": #number,
    "total_pages": #number,
    "data": #array,
    "support": {
        "url": "##string",
        "text": "##string"
    }
}
    """
    # schema kontrolü bir dosya üzerinden de yapılabilir. Bunun için read komutu kullanılır
    * def responseSchema = read("classpath:reqres/jsons/getUsersResponseSchema.json")
    * match response == responseSchema
