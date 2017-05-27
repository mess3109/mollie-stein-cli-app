class PersonalizedRecipes::Scraper

  def self.scrape_site
    doc = Nokogiri::HTML(open("https://food52.com/recipes/"))
    doc.css(".collectable-tile.js-collectable-tile.quick-basket-wrap h3").children.css("a").each{|link|
      if link.attribute("title")
        recipe = PersonalizedRecipes::Recipe.new
        recipe.title = link.attribute("title").value
        recipe.url = link.attribute("href").value
        recipe.save
      end
    }
  end

  def self.scrape_recipe(recipe)
    #doc = Nokogiri::HTML(open("https://food52.com/recipes/70890-sabu-s-purple-kale-salad"))
    doc = Nokogiri::HTML(open("https://food52.com" + recipe.url))
    recipe.starred = doc.css(".counter").text
    recipe.yield = doc.css(".recipe p strong").text
    recipe.ing_list = doc.css(".recipe-list").children.css("li").collect{|child| child.css(".recipe-list-quantity").text + " " + child.css(".recipe-list-item-name").text.strip}
    recipe.instructions = doc.css("ol li").collect{|item| item.text.strip}
  end

end
