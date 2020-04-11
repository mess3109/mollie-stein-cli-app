class PersonalizedRecipes::Scraper

  def self.scrape_site
    doc = Nokogiri::HTML(open("https://food52.com/recipes/search/"))
    doc.css(".collectable-tile.js-collectable-tile").each do |section|
      recipe = PersonalizedRecipes::Recipe.new
      section.children.css("h3 a").each do |link|
        if link.attribute("title")
          recipe.title = link.attribute("title").value
          recipe.url = link.attribute("href").value
        end
      end
      recipe.save
    end
  end

  #input is an instance of a recipe
  def self.scrape_recipe(recipe)
    doc = Nokogiri::HTML(open("https://food52.com" + recipe.url))
    recipe.yield = doc.css("p[itemprop='recipeYield']").text.strip
    recipe.instructions = doc.css("ol li").collect{|item| item.text.strip}
  end

  #ingredients are scraped separately to exclude recipes at the beginning
  def self.scrape_ingredient_list(recipe)
    doc = Nokogiri::HTML(open("https://food52.com" + recipe.url))
    recipe.ing_list = doc.css(".recipe-list").children.css("li").collect{|child| child.css(".recipe-list-quantity").text + " " + child.css(".recipe-list-item-name").text.strip}
  end

end
