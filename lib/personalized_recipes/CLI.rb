#Our CLI Controller

class PersonalizedRecipes::CLI

  attr_accessor :recipes

  def initialize
    start
  end

  def start
    list_recipes
    menu
    end_program
  end

  def list_recipes
    @recipes = PersonalizedRecipes::Recipe.all
    @recipes.each.with_index(1) { |recipe, i|
      puts "#{i}. #{recipe.name} - favorited by #{recipe.favorited}"
    }
  end

  def menu
    input = nil
    while input != "exit"
      puts "Which Recipe would you like to view?  Or type list to see recipes again.  Or type exit. "
      input = gets.strip
      if input.to_i > 0
        puts @recipes[input.to_i-1].name
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
