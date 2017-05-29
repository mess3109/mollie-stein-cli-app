class PersonalizedRecipes::CLI

  attr_accessor :recipes, :total, :ingredients_to_remove, :recipes_all

  @@ingredients_to_remove_mes = ["instant", "chicken", "beef", "steak", "bacon", "pork", "ham", "cilantro", "orange", "oranges"]

  def initialize
    @@ingredients_to_remove = []
    start
  end

  def self.ingredients_to_remove
    @@ingredients_to_remove
  end

  def recipes_all
    PersonalizedRecipes::Recipe.all
  end

  def start
    welcome_message
    call_scrape
    list_recipes
    menu
    end_program
  end

  def welcome_message
    puts "\n------- Welcome to Personalized Recipes -------"
    remove_ingredients
    puts "\nPulling featured recipes from Food52 without the following ingredients...\n\n"
    @@ingredients_to_remove.each{ |item|
      puts item
    }
  end

  def remove_ingredients
    puts "\nWhich ingredients would you like to exclude?  \n  Input one word at a time without spaces  \n  Input none for all recipes  \n  Input done when finished  \n"
    input = nil
    while input != "done"
      input = gets.strip.downcase
      if input.to_i > 0
        puts "Invalid input."
      elsif input == "none"
        @@ingredients_to_remove = Array.new
        input = "done"
      elsif input == "mes"
        @@ingredients_to_remove = @@ingredients_to_remove_mes
        input = "done"
      elsif input == "done"
      else
        @@ingredients_to_remove << input
      end
    end
  end

  def call_scrape
    PersonalizedRecipes::Scraper.scrape_site
    all_clone = PersonalizedRecipes::Recipe.all.clone
    all_clone.each { |recipe|
      PersonalizedRecipes::Scraper.scrape_ingredient_list(recipe)
      PersonalizedRecipes::Recipe.remove_recipe(recipe)
      }
  end

  def list_recipes
    puts "\nHow many recipes are you interested in today (up to #{recipes_all.length})?"
    @@total = gets.strip.to_i - 1
    if @@total < 0 || @@total > recipes_all.length - 1
      puts "Invalud input."
      list_recipes
    end
    puts "\n-------  Recipes  -------\n\n"
    @recipes = recipes_all[0..@@total]
    @recipes.each.with_index(1) { |recipe, i|
      puts "#{i}. #{recipe.title} - starred by #{recipe.starred}"
    }
    puts "\nWhich Recipe would you like to view?"
  end

  def menu
    input = nil
    while input != "exit"
      input = gets.strip
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
      elsif input == "exit"
      else
        puts "Invalid input.  Please type list or exit.\n"
      end
    end
  end

  def end_program
    puts "Bon Appetit!"
  end

end
