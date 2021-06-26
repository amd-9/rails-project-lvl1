# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative "simple_tag"
require_relative "pair_tag"

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  module Tag
    def self.build(tag_name, **kwargs, &block)
      tag = block_given? ? PairTag.new(tag_name, kwargs, content: block.call) : SimpleTag.new(tag_name, kwargs)
      tag.to_s
    end
  end
end
