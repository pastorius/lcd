module LCD
  class Glyphizer
    def glyphs_from_string(s)
      s.chars.map {|g| Glyph.new(g) }
    end
  end

  class Glyph
    def initialize(g)
      @segments = known.fetch(g) { raise "Unknown glyph: #{g}" }
    end

    def enabled_for_segment?(s)
      segments.include?(s)
    end

    private
    attr_reader :segments

    def known
      {
        '0' => [0, 1, 2, 4, 5, 6],
        '1' => [1, 4],
        '2' => [0, 1, 3, 5, 6],
        '3' => [0, 1, 3, 4, 6],
        '4' => [1, 2, 3, 4],
        '5' => [0, 2, 3, 4, 6],
        '6' => [0, 2, 3, 4, 5, 6],
        '7' => [0, 1, 4],
        '8' => [0, 1, 2, 3, 4, 5, 6],
        '9' => [0, 1, 2, 3, 4, 6],
        'A' => [0, 1, 2, 3, 4, 5],
        'B' => [0, 1, 2, 3, 4, 5, 6],
        'C' => [0, 2, 5, 6],
        'D' => [0, 1, 2, 4, 5, 6],
        'E' => [0, 2, 3, 5, 6],
        'F' => [0, 2, 3, 5]
      }
    end
  end
end