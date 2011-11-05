require 'watir-webdriver'
require 'cgi'

class Rym
  def initialize
    @browser = Watir::Browser.new
    @browser.goto 'http://rateyourmusic.com'
  end

  def search_artist *args
    @browser.text_field(:id => 'searchfield').set args.join ' '
    @browser.button(:id => 'searchgo').click
    @browser.as(:class => 'searchpage').map(&:text)
  end

  def close
    @browser.close
  end
end