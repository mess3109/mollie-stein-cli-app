#Our CLI Controller

class PersonalizedRecipes::CLI

  attr_accessor :recipes, :total, :ingredients_to_remove

  @@ingredients_to_remove = ["beef", "chicken", "steak", "pork", "ham", "cilantro", "orange", "oranges"]

  def initialize
    start
  end

  def self.ingredients_to_remove
    @@ingredients_to_remove
  end

  def start
    puts "How many recipes are you interested in today?"
    @@total = gets.strip.to_i - 1
    PersonalizedRecipes::Scraper.scrape_site
    all_clone = PersonalizedRecipes::Recipe.all.clone
    PersonalizedRecipes::Recipe.all.each { |recipe|
      PersonalizedRecipes::Scraper.scrape_ingredient_list(recipe)
      }
    #all_clone created for iteration
    all_clone.each { |recipe|
      PersonalizedRecipes::Recipe.remove_recipe(recipe)
      }
    list_recipes
    menu
    end_program
  end

  def list_recipes
    puts "-------  Recipes  -------"
    @recipes = PersonalizedRecipes::Recipe.all[0..@@total-1]
    @recipes.each.with_index(1) { |recipe, i|
      puts "#{i}. #{recipe.title} - starred by #{recipe.starred}"
    }
  end

  def menu
    input = nil
    while input != "exit"
      puts "Which Recipe would you like to view?  Or type list to see recipes again.  Or type exit. "
      input = gets.strip
      #Add validation function for recipe #
      if input.to_i > 0
        recipe = @recipes[input.to_i - 1]
         #prevents scraping more than once
         if recipe.yield == nil
           PersonalizedRecipes::Scraper.scrape_recipe(recipe)
         end
        recipe.print
      elsif input == "list"
        list_recipes
      elsif input == "exit"
        input = exit
      else
        puts "Invalid input.  Please type list or exit."
      end
    end
  end

  def end_program
    puts "Bon appetit!"
  end

end
