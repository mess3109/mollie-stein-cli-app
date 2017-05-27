class PersonalizedRecipes::Recipe
  attr_accessor :recipes, :title, :starred, :url, :yield, :ing_list, :instructions
  @@recipes = []

  def self.all
    @@recipes
  end

  def save
    @@recipes << self
  end
end
