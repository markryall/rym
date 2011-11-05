$: << File.dirname(__FILE__)+'/../..lib'

require 'rym'

describe Rym do
  let(:rym) { Rym.new }

  #after { rym.close }

  it 'should search artist' do
    rym.search_artist('sepulture').first.should == 'Sepultura'
  end

  it 'should search artist' do
    rym.search_artist('tmbg').should == ['They Might Be Giants']
  end

  it 'should retrive artist' do
    rym.artist('they might be giants').albums[3..6].should == ['Lincoln', 'Flood', 'Apollo 18', 'John Henry']
  end
end