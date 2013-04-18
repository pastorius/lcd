require 'spec_helper'
require 'lcd'

include LCD 

describe TerminalView do
  it 'should work' do
    t = TerminalView.new
    t.print_glyphs(:size => 3, :string => "0123456789")
  end
end