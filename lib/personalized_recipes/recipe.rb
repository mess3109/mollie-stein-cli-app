class PersonalizedRecipes::Recipe
  attr_accessor :title, :starred, :url

  def self.all
    #scrape Food52
    recipe_1 = self.new
    recipe_1.title = "Spaghetti with Squash"
    recipe_1.url = "http://"
    recipe_1.starred = "11"

    recipe_2 = self.new
    recipe_2.title = "Rigatoni alla Norma"
    recipe_2.url = "http://"
    recipe_2.starred = "10"

    [recipe_1, recipe_2]
  end

  # def self.scrape_site
  #   doc = Nokogiri::HTML(open("https://food52.com/recipes/"))
  #   binding.pry
  #   doc.css(".collectable-tile.js-collectable-tile.quick-basket-wrap h3 a").first.attribute("href").value
  # end

end
