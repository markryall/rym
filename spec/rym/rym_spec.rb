$: << File.dirname(__FILE__)+'/../..lib'

require 'rym'

describe Rym do
  let(:rym) { Rym.new }

  #after { rym.close }

  def d *args
    Date.new *args
  end

  it 'should search artist' do
    rym.search_artist('sepulture').first.should == 'Sepultura'
  end

  it 'should search artist' do
    rym.search_artist('tmbg').should == ['They Might Be Giants']
  end

  it 'should retrive artist album titles' do
    rym.artist('they might be giants').albums[3..6].map(&:title).should == ['Lincoln', 'Flood', 'Apollo 18', 'John Henry']
  end

  it 'should retrieve artist album release dates' do
    rym.artist('they might be giants').albums[3..6].map(&:date).should == [d(1988,11,15), d(1990,1,5), d(1992,3,24), d(1994,9,13)]
  end
end