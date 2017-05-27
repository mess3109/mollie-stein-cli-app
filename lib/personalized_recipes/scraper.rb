class PersonalizedRecipes::Scraper

  def self.scrape_site
    doc = Nokogiri::HTML(open("https://food52.com/recipes/"))

    doc.css(".collectable-tile.js-collectable-tile.quick-basket-wrap").each{ |section|
      recipe = PersonalizedRecipes::Recipe.new
      section.children.css("h3 a").each{|link|
        if link.attribute("title")
          recipe.title = link.attribute("title").value
          recipe.url = link.attribute("href").value
        end
        }
      recipe.starred = section.children.css(".counter").text
      recipe.save
    }
  end

#input is an instance of a recipe
  def self.scrape_recipe(recipe)
    doc = Nokogiri::HTML(open("https://food52.com" + recipe.url))
    recipe.yield = doc.css(".recipe p strong").text
    recipe.ing_list = doc.css(".recipe-list").children.css("li").collect{|child| child.css(".recipe-list-quantity").text + " " + child.css(".recipe-list-item-name").text.strip}
    recipe.instructions = doc.css("ol li").collect{|item| item.text.strip}
  end

end
