require 'watir-webdriver'
require 'cgi'

class Artist
  attr_reader :albums
  def initialize albums
    @albums = albums
  end
end

class Album
  attr_reader :title, :date
  def initialize title, date
    @title, @date = title, date
  end
end

class Rym
  def initialize
    @browser = Watir::Browser.new
  end

  def search_artist *args
    @browser.goto 'http://rateyourmusic.com'
    @browser.text_field(:id => 'searchfield').set args.join ' '
    @browser.button(:id => 'searchgo').click
    @browser.as(:class => 'searchpage').map(&:text)
  end

  def artist name
    @browser.goto "http://rateyourmusic.com/artist/#{name.gsub(' ', '_')}"
    albums = @browser.table(:id => 'album_disc_s').rows[2..-1].map do |r|
      title = r.tds[1].a.text
      date = parse_date r.td.span.title
      Album.new title, date
    end
    artist = Artist.new albums
    artist
  end

  def close
    @browser.close
  end
private
  MONTHS = %w{Nothing January February March April May June July August September October November December}

  def parse_date s
    day = 15
    month = 6
    year = 2000
    case s
    when /(\w+) (\d+), (\d+)/
      month = MONTHS.index $1
      day = $2.to_i
      year = $3.to_i
    when /(\w+) (\d+)/
      month = MONTHS.index $1
      year = $2.to_i
    when /(\d+)/
      year = $1.to_i
    end
    Date.new year, month, day
  end
end