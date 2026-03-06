@pet
Feature: Pruebas de API para PetStore - Gestión Completa de Mascotas

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * header api_key = apiKey

  @crud @create
  Scenario Outline: A01. Crear nueva mascota usando datos de JSON
    # Leer datos del archivo JSON
    * def petsData = read('classpath:data/pets.json')
    * def newPet = petsData.validPets[<row>]

    Given path '/v2/pet'
    And request newPet
    When method POST
    Then status 200
    And match response.id == newPet.id
    And match response.name == newPet.name
    And match response.status == newPet.status
    And print 'Mascota creada: ' + response.name + ' (ID: ' + response.id + ')'

    Examples:
      | row |
      | 0   |
      | 1   |
      | 2   |

  @crud @get
  Scenario Outline: A02. Consultar mascota por ID
    * def petsData = read('classpath:data/pets.json')
    * def pet = petsData.validPets[<row>]

    # Crear la mascota primero para asegurar que existe
    Given path '/v2/pet'
    And request pet
    When method POST
    Then status 200

    # Ahora consultarla
    Given path '/v2/pet', pet.id
    When method GET
    Then status 200
    And match response.id == pet.id
    And match response.name == pet.name
    And print 'Mascota encontrada: ' + response.name

    Examples:
      | row |
      | 0   |
      | 1   |
      | 2   |

  @crud @update
  Scenario Outline: A03. Actualizar mascota existente
    * def petsData = read('classpath:data/pets.json')
    * def originalPet = petsData.validPets[<row>]

    # Crear la mascota primero si no existe
    Given path '/v2/pet'
    And request originalPet
    When method POST
    Then status 200

    # Modificar los datos
    * def updatedPet = originalPet
    * set updatedPet.name = originalPet.name + ' Actualizado'
    * set updatedPet.status = 'sold'

    Given path '/v2/pet'
    And request updatedPet
    When method PUT
    Then status 200
    And match response.name == updatedPet.name
    And match response.status == updatedPet.status
    And print 'Mascota actualizada: ' + response.name

    Examples:
      | row |
      | 0   |
      | 1   |
      | 2   |

  @crud @findByStatus
  Scenario Outline: A04. Buscar mascotas por diferentes estados
    Given path '/v2/pet/findByStatus'
    And param status = '<status>'
    When method GET
    Then status 200
    And def petCount = karate.sizeOf(response)
    And print 'Status: ' + '<status>' + ' - Encontradas: ' + petCount

    Examples:
      | status |
      | available |
      | pending |
      | sold |

  @crud @delete
  Scenario Outline: A05. Eliminar mascota
    * def petsData = read('classpath:data/pets.json')
    * def petToDelete = petsData.validPets[<row>]

    Given path '/v2/pet', petToDelete.id
    When method DELETE
    Then status 200
    And match response.code == 200
    And print 'Mascota eliminada: ' + petToDelete.name

    Examples:
      | row |
      | 0   |
      | 1   |
      | 2   |

  @negative @invalid
  Scenario Outline: B01. Pruebas negativas con IDs inválidos
    Given path '/v2/pet', <id>
    When method GET
    Then status 404
    And match response.message contains 'not found'
    And print 'Error esperado para ID: ' + <id>

    Examples:
      | id |
      | -99999 |
      | 0 |
      | 999999999 |
      | -1 |