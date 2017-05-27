class PersonalizedRecipes::Recipe
  attr_accessor :recipes, :title, :starred, :url, :yield, :ing_list, :instructions
  @@recipes = []

  def self.all
    @@recipes
  end

  def save
    @@recipes << self
  end

  def print
    puts "----- #{@title} ----- \n\n"
    puts "Starred by #{@starred} people\n\n"
    puts "#{@yield} \n\n"
    puts "----- Ingredients ----- \n\n"
    @ing_list.each{ |ing|
     puts ing.strip
     }
    puts "\n"
    puts "----- Instructions ----- \n\n"
    @instructions.each.with_index(1) {|instr, index|
      puts "#{index}. #{instr} \n\n"
      }
  end

  def self.remove_recipe(recipe)
    if recipe.ing_list.collect{|item| item.downcase.split(" ")}.flatten & PersonalizedRecipes::CLI.ingredients_to_remove != Array.new
      self.all.delete(recipe)
    end
  end

end
