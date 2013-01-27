Feature: Graphs
  In order to see how a dataset has changed over time
  As an interested party
  I want to be able to see a graph

  Scenario: List all datasets
    Given a dataset exists
    When I view the list of all datasets
    Then I should see "Datasets#index"

  Scenario: Show a basic graph of a dataset
    Given a dataset exists
    When I view that dataset
    Then I should see "Datasets#show"