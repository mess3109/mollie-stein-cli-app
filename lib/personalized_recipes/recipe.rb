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
      puts ing
      }
    puts "\n"
    puts "----- Instructions ----- \n\n"
    @instructions.each.with_index(1) {|instr, index|
      puts "#{index}. #{instr} \n\n"
      }
  end
end
