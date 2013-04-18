require "lcd/version"
require "lcd/glyph"
require 'lcd/segment_printer'

module LCD
  class TerminalView
    def initialize(opts = {})
      @glyphizer = opts[:glyphizer] || Glyphizer.new
      @segment_printers = opts.fetch(:segment_printers, [
        HorizontalSegmentPrinter.new(:segments => 0),
        VerticalSegmentPrinter.new(:segments => [2, 1]),
        HorizontalSegmentPrinter.new(:segments => 3),
        VerticalSegmentPrinter.new(:segments => [5, 4]),
        HorizontalSegmentPrinter.new(:segments => 6)
      ])
    end

    def print_glyphs(opts = {})
      glyphs = glyphizer.glyphs_from_string(opts[:string])
      puts
      segment_printers.each {|p| p.print_segments(glyphs, opts)}
      puts
    end

    private 
    attr_reader :glyphizer, :segment_printers
  end
end