#Our CLI Controller

class PersonalizedRecipes::CLI

  attr_accessor :recipes, :total

  def initialize
    start
  end

  def start
    PersonalizedRecipes::Scraper.scrape_site
    puts "How many recipes are interested in today?"
    @@total = gets.strip.to_i - 1
    list_recipes
    menu
    end_program
  end

  def list_recipes
    puts "-----  Recipes  -----"
    @recipes = PersonalizedRecipes::Recipe.all[0..@@total]
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
      elsif input== "list"
        list_recipes
      else
        puts "Invalid input.  Please type list or exit."
      end
    end
  end

  def end_program
    puts "Bon appetit!"
  end

end
