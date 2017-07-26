require 'open-uri'

class Scrapper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    meetups = []

    page.css(".j-groupCard-list").each do |card|
      card.css(".groupCard").each do |meetup|
        meetup_link = meetup.css("a").attr("href").text.strip
        title = meetup.css(".groupCard--title h3").text.strip
        member_count = meetup.css(".groupCard--title p").text.strip
        meetups << {meetup_link: meetup_link, title: title, member_count: member_count}
      end
    end
    meetups
  end

  def self.scrape_detail_page(meetup_link)
    meetup = {}
    page = Nokogiri::HTML(open(meetup_link))

    if page.include?("C_page")
      meetup[:organizer] = page.css("#meta-leaders a").text
      meetup[:location] = page.css(".adr h3 a span").attr(".addressLocality").text
    else
      meetup[:organizer] = ""
      meetup[:location] = ""
    end

  end

end
