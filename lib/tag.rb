# frozen_string_literal: true

require_relative 'html_tag'

module HexletCode
  class Tag
    def self.build(tag_name, **kwargs, &block)
      content = block_given? ? block.call : ''
      HtmlTag.new(tag_name, kwargs, content: content).to_s
    end
  end
end
