#Our CLI Controller

class PersonalizedRecipes::CLI

  def initialize
    start
  end

  def start
    list_recipes
    menu
  end

  def list_recipes
    puts <<-DOC
    1.  Recipe
    2.  Recipe
    3.  Recipe
    4.  Recipe
    5.  Recipe
    DOC
  end

  def menu
    input = nil
    while input != "exit"
      puts "Which Recipe would you like to view?  Or type list to see recipes again.  Or type exit. "
      input = gets.strip
      if input == "list"
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
