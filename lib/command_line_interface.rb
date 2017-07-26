require_relative "../lib/scrapper.rb"
require_relative "../lib/meetup.rb"
require 'nokogiri'

class CommandLineInteface
  BASE_PATH = "https://www.meetup.com/find/tech/"

  def run
    make_meetups
    puts "Here is the list of NYC Tech Meetups"
    display_lite
    start
    # add_details_to_meetups


    # display_meetups
  end

  def make_meetups
    meetups_array = Scrapper.scrape_index_page(BASE_PATH)
    Meetup.create_from_list(meetups_array)
  end

  def add_details_to_meetup(index)
    meetup = Meetup.all[index-1]
    details = Scrapper.scrape_detail_page(meetup.meetup_link)
    meetup.add_meetup_details(details)
  end

  def start
    puts " "
    puts "Which meet up would you like to see more in detail? Enter the meetup number"
    input = gets.strip.to_i

    display_meetup(input)

    puts " "
    puts "Would you like to see other meetups? Enter Y or N"

    input = gets.strip.downcase
    if input == "y"
      display_lite
      start
    else
      puts ""
      puts "Thank you! Have a great day!"
      exit
    end

  end

  def display_lite
    Meetup.all.each_with_index do |meetup, index|
      puts "#{index+1} - #{meetup.title.upcase} - #{meetup.member_count}"
    end
  end

  def display_meetup(index)
    add_details_to_meetup(index)
    meetup = Meetup.all[index-1]
    puts "#{meetup.title.upcase}"
    puts "  location: #{meetup.location}"
    puts "  members: #{meetup.member_count}"
    puts "  organizer: #{meetup.organizer}"
    puts "----------------------"
  end

end
