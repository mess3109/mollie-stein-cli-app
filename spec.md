# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
      The CLI class is how the user interacts with the application within the terminal.  It starts the program and the user has to input what ingredients should be excluded from the recipes and how many recipes should be listed.
- [x] Pull data from an external source
      The Scraper class pulls recipes from the website https://food52.com/recipes/.  The application first pulls the urls for each recipe and creates an instance of a Recipe.  Then it pulls the ingredient list for each recipe by going to the recipes url.  To save time, the instructions are scraped once the user requests to see more detail of a recipe.
- [x] Implement both list and detail views
      The application lists the names of the recipes and how many people starred it.  From the list of recipes, the user selects which recipe by number to see the full ingredients list and instructions.  
