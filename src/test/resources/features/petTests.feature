@pet
Feature: Pruebas de API para PetStore - Gestión Completa de Mascotas

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * def petId = 10000


  @addPet @crud
  Scenario: 1. Añadir una nueva mascota a la tienda
    Given def newPet =
    """
    {
      "id": #(petId),
      "category": {
        "id": 1,
        "name": "Perros"
      },
      "name": "Firulais",
      "photoUrls": [
        "https://example.com/dog.jpg"
      ],
      "tags": [
        {
          "id": 1,
          "name": "jugueton"
        },
        {
          "id": 2,
          "name": "amigable"
        }
      ],
      "status": "available"
    }
    """
    Given path '/v2/pet'
    And request newPet
    When method POST
    Then status 200
    And match response.id == petId
    And match response.name == 'Firulais'
    And match response.status == 'available'
    And print '=== Mascota agregada exitosamente ==='
    And print response

  @getPet @crud
  Scenario: 2. Consultar la mascota por ID
    Given path '/v2/pet', petId
    When method GET
    Then status 200
    And match response.id == petId
    And match response.name == 'Firulais'
    And match response.status == 'available'
    And print '=== Mascota encontrada por ID ==='
    And print response

  @updatePet @crud
  Scenario: 3. Actualizar la mascota existente
    Given def updatedPet =
    """
    {
      "id": #(petId),
      "category": {
        "id": 1,
        "name": "Perros"
      },
      "name": "Firulais Actualizado",
      "photoUrls": [
        "https://example.com/dog_updated.jpg"
      ],
      "tags": [
        {
          "id": 1,
          "name": "muy jugueton"
        }
      ],
      "status": "sold"
    }
    """
    Given path '/v2/pet'
    And request updatedPet
    When method PUT
    Then status 200
    And match response.name == 'Firulais Actualizado'
    And match response.status == 'sold'

  @findByStatus @crud
  Scenario: 4. Buscar mascotas por estado
    Given path '/v2/pet/findByStatus'
    And param status = 'sold'
    When method GET
    Then status 200
    And def responseList = response
    And assert response.length > 0
    And print '=== Mascotas vendidas encontradas ==='
    And print 'Total encontradas: ' + responseList.length

  @deletePet @crud
  Scenario: 5. Eliminar una mascota
    Given path '/v2/pet', petId
    When method DELETE
    Then status 200
    And print '=== Mascota eliminada exitosamente ==='

  @negative @invalidId
  Scenario: 6. Intentar obtener mascota con ID inválido (negativo)
    Given path '/v2/pet', -999999
    When method GET
    Then status 404
    And match response.type == 'error'
    And match response.message contains 'Pet'
