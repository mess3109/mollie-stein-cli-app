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

end
