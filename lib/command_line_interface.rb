require_relative "../lib/scrapper.rb"
require_relative "../lib/meetup.rb"
require 'nokogiri'

class CommandLineInteface
  BASE_PATH = "https://www.meetup.com/find/tech/"

  def run
    make_meetups
    add_details_to_meetups
    # add_attributes_to_students
    # display_students
  end

  def make_meetups
    meetups_array = Scrapper.scrape_index_page(BASE_PATH)
    Meetup.create_from_list(meetups_array)
  end

  def add_details_to_meetups
    Meetup.all.each do |meetup|
      details = Scrapper.scrape_detail_page(meetup.meetup_link)
      # student.add_student_attributes(attributes)
    end
  end
  #
  # def display_students
  #   Student.all.each do |student|
  #     puts "#{student.name.upcase}".colorize(:blue)
  #     puts "  location:".colorize(:light_blue) + " #{student.location}"
  #     puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
  #     puts "  bio:".colorize(:light_blue) + " #{student.bio}"
  #     puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
  #     puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
  #     puts "  github:".colorize(:light_blue) + " #{student.github}"
  #     puts "  blog:".colorize(:light_blue) + " #{student.blog}"
  #     puts "----------------------".colorize(:green)
  #   end
  # end

end
