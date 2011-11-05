$: << File.dirname(__FILE__)+'/../..lib'

require 'rym'

describe Rym do
  let(:rym) { Rym.new }

  it 'should search artist' do
    rym.search_artist('sepulture').first.should == 'sepultura'
  end

  it 'should search artist' do
    rym.search_artist('tmbg').should == 'They Might Be Giants'
  end
end