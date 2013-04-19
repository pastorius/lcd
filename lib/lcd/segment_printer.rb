module LCD

  module Printable
    def print_char(c)
      print c
    end

    def print_off
      print_char off
    end

    def on() '-'; end
    def off() ' '; end
  end

  module SegmentPrinter
    include Printable

    def initialize(opts = {})
      @segments = Array(opts[:segments])
    end

    protected
    attr_reader :segments

    def print_line(glyphs)
      glyphs.each do |g|
        yield g
        print_off
      end
      puts
    end

    def print_char_for_glyph_segment(s, g)
      print_char char_for_glyph_segment(s, g)
    end

    def char_for_glyph_segment(s, g)
      g.enabled_for_segment?(s) ? on : off
    end
  end

  class HorizontalSegmentPrinter
    include SegmentPrinter

    def print_segments(glyphs, opts)
      print_line(glyphs) do |g|
        print_off        
        opts[:size].times { print_char_for_glyph_segment(segments.first, g) }
        print_off
      end
    end
  end

  class VerticalSegmentPrinter
    include SegmentPrinter

    def print_segments(glyphs, opts)
      opts[:size].times do
        print_line(glyphs) {|g| print_segments_for_glyph(g, opts) }
      end
    end

    private

    def print_segments_for_glyph(g, opts)
      print_char_for_glyph_segment(segments.first, g)
      opts[:size].times { print_off }
      print_char_for_glyph_segment(segments.last, g)
    end

    def on() '|'; end
  end
end