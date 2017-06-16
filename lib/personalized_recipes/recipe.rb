class PersonalizedRecipes::Recipe
  attr_accessor :recipes, :title, :starred, :url, :yield, :ing_list, :instructions, :ingredients_to_remove_mes
  @@recipes = []

  @@ingredients_to_remove_mes = ["instant", "chicken", "beef", "steak", "bacon", "pork", "ham", "cilantro", "orange", "oranges"]

  def self.all
    @@recipes
  end

  def save
    @@recipes << self
  end

  def self.remove_recipe(recipe)
    if recipe.ing_list.collect{|item| item.downcase.split(" ")}.flatten.collect{|item| item.gsub(/[^A-Za-z]/,"")} & PersonalizedRecipes::CLI.ingredients_to_remove != Array.new
      self.all.delete(recipe)
    end
  end

  def self.ingredients_to_remove_mes
     @@ingredients_to_remove_mes
  end

end
