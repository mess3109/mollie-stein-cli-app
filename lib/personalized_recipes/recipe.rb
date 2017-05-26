class PersonalizedRecipes::Recipe
  attr_accessor :name, :favorited, :url

  def self.all
    recipe_1 = self.new
    recipe_1.name = "Spaghetti with Squash"
    recipe_1.url = "http://"
    recipe_1.starred = "11"

    recipe_2 = self.new
    recipe_2.name = "Rigatoni alla Norma"
    recipe_2.url = "http://"
    recipe_2.starred = "10"

    [recipe_1, recipe_2]
  end

end
