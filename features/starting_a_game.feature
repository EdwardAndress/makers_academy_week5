Feature: Starting the game
	In order to play battleships
	As a nostalgic player
	I want to start a new game

	Scenario: Registering
		Given I am on the homepage
		When I follow "New Game"
		Then I should see "Please enter the names of both players"

	Scenario:
		Given I am on the name page
		And I fill in "player1name" with "Nicola"
		When I press "Submit"
		Then I should see "Welcome, Nicola" 
		When I follow "Proceed"
		Then I should see "Let's start the game Nicola"
		And I should see "You have 5 ships to deploy."
		# Then I press "submit"
		# Then I should see "You have 4 ships to deploy"
