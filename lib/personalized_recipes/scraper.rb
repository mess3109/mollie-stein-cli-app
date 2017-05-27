class PersonalizedRecipes::Scraper

  def self.scrape_site
    doc = Nokogiri::HTML(open("https://food52.com/recipes/"))
    recipes = []
    doc.css(".collectable-tile.js-collectable-tile.quick-basket-wrap h3").children.css("a").each{|link|
      if link.attribute("title") != nil
        puts link.attribute("title").value
        puts link.attribute("href").value
      end
    }
  end

end
