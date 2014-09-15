Battleships-Web-App
===================

This is web application for battleships, built during week 5 of Makers Academy, using Sinatra, Ruby and Capybara. The aim was to implement a two-player game without using a database, which was carried out using a global variable for game and session cookies.

###Specification

+ Create a game of battleships on the web which two players can play against each other in seperate browsers.

###Technologies used

+ Ruby
+ RSPEC
+ Capybara
+ Sinatra
+ Git

###How to set it up

```sh
git clone https://github.com/aitkenster/Battleships-Web-Application.git
```

###How to run it

```sh
cd Battleships-Web-Application
bundle install
rackup
```

visit localhost:9292 to view

###How to test it

```sh
cd Battleships-Web-Application
rspec
``` 

###Future Improvements

+ Add CSS
+ Improve the integration tests - this was my first attempt at using Capybara and Cucumber and test coverage could be better
