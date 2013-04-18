module LCD
  module SegmentPrinter
    def initialize(opts = {})
      @segments = Array(opts[:segments])
    end

    def print_segments(glyphs, opts)
    end

    protected
    attr_reader :segments

    def print_glyphs(glyphs)
      glyphs.each do |g|
        yield g
        print_off
      end
      puts
    end

    def print_glyph(s, g)
      g.enabled_for_segment?(s) ? print_on : print_off
    end

    def print_on
      print on
    end

    def print_off
      print off
    end

    def on() '-'; end
    def off() ' '; end
  end

  class HorizontalSegmentPrinter
    include SegmentPrinter

    def print_segments(glyphs, opts)
      print_glyphs(glyphs) do |g|
        print_off        
        opts[:size].times { print_glyph(segments.first, g) }
        print_off
      end
    end
  end

  class VerticalSegmentPrinter
    include SegmentPrinter

    def print_segments(glyphs, opts)
      opts[:size].times do
        print_glyphs(glyphs) {|g| print_active_segments_for_glyph(g, opts) }
      end
    end

    private

    def print_active_segments_for_glyph(g, opts)
      print_glyph(segments.first, g)
      opts[:size].times { print_off }
      print_glyph(segments.last, g)
    end

    def on() '|'; end
  end
end