require 'open-uri'

class Scrapper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    meetups = []

    page.css(".j-groupCard-list").each do |card|
      card.css(".groupCard").each do |meetup|
        title = meetup.css(".groupCard--title").attr("h3").text
        member_count = meetp.css(".groupCard--title").attr("p").text
        meetups << {title: title, member_count: member_count}
      end
    end
    meetups
  end

end
