# frozen_string_literal: true

module Aoc
  def self.parse_file(file)
    lines = IO.readlines file
    lines.map!(&:strip)
    lines.reject(&:empty?)
  end
end
