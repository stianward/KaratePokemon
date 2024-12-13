Feature: Validate Pokemon names and evolutions

  Background:
    * url 'https://pokeapi.co/api/v2/'

  Scenario Outline: Validate that Pokemon names and evolutions are returned from API
  # Validate that pokemon exist and response is 200
    Given path 'pokemon', namePokemon
    When method GET
    Then status 200
    And match response.name == namePokemon

    # Validate the pokemon evolution
    Given path 'pokemon-species', namePokemon
    When method GET
    Then status 200
    And match response.name == namePokemon
    And def evolutionChainUrl = response.evolution_chain.url

    # Validate the evolutions from evolution chain
    Given url evolutionChainUrl
    When method GET
    Then status 200
    And match response.chain.species.name == namePokemon
    And match response.chain.evolves_to[0].species.name == PokemonEvolution_2
    And match response.chain.evolves_to[0].evolves_to[0].species.name == PokemonEvolution_3

    Examples:
      | namePokemon | PokemonEvolution_2 | PokemonEvolution_3   |
      | charmander  | charmeleon         | charizard            |
