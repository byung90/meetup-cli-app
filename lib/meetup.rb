class Meetup
  attr_accessor :title, :member_count, :organizer, :location, :meetup_link

  @@all=[]

  def initialize(meetup_hash)
    meetup_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
    puts @@all
  end

  def self.create_from_list(meetups)
    meetups.each do |meetup_hash|
      Meetup.new(meetup_hash)
    end
  end

  def self.all
    @@all
  end

end
