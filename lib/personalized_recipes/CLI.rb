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
    puts "How many recipes are you interested in today (up to 24)?"
    @@total = gets.strip.to_i - 1
    if @@total < 0 || @@total > 23
      puts "Invalud input."
      start
    end
    PersonalizedRecipes::Scraper.scrape_site
    all_clone = PersonalizedRecipes::Recipe.all.clone
    all_clone.each { |recipe|
      PersonalizedRecipes::Scraper.scrape_ingredient_list(recipe)
      PersonalizedRecipes::Recipe.remove_recipe(recipe)
      }
    list_recipes
    menu
    end_program
  end

  def list_recipes
    puts "\n-------  Recipes  -------"
    @recipes = PersonalizedRecipes::Recipe.all[0..@@total]
    @recipes.each.with_index(1) { |recipe, i|
      puts "#{i}. #{recipe.title} - starred by #{recipe.starred}"
    }
    puts "\nWhich Recipe would you like to view?"
  end

  def menu
    input = nil
    while input != "exit"
      #puts "Which Recipe would you like to view?  Or type list to see recipes again.  Or type exit. "
      input = gets.strip
      #Add validation function for recipe #
      if input.to_i > 0 && input.to_i <= @@total + 1
        recipe = @recipes[input.to_i - 1]
         #prevents scraping more than once
         if recipe.yield == nil
           PersonalizedRecipes::Scraper.scrape_recipe(recipe)
         end
        recipe.print
        puts "Please type list or exit."
      elsif input == "list"
        list_recipes
      else
        puts "Invalid input.  Please type list or exit.\n"
      end
    end
  end

  def end_program
    puts "Bon appetit!"
  end

end
