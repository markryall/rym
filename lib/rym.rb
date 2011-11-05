require 'watir-webdriver'
require 'cgi'

class Artist
  attr_reader :albums

  def initialize albums
    @albums = albums
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
      # date = r.td.span.title
      r.tds[1].a.text
    end
    artist = Artist.new albums
    artist
  end

  def close
    @browser.close
  end
end