class PersonalizedRecipes::Recipe
  attr_accessor :title, :starred, :url, :recipes, :yield, :ing_list, :instructions
  @@recipes = []

  def self.all
    @@recipes
  end

  def save
    @@recipes << self
  end
end
