# frozen_string_literal: true

module HexletCode
  class Tag
    attr_reader :tag_name, :attributes, :content

    def self.build(tag_name, **kwargs, &block)
      content = block_given? ? block.call : nil
      tag = Tag.new(tag_name, kwargs) { content }
      tag.to_s
    end

    def initialize(tag_name, attributes = {}, &block)
      @tag_name = tag_name
      @attributes = attributes
      @content = block_given? ? block.call : nil
    end

    def build_tag_string
      return "<#{@tag_name}#{attributes_string}>" if content.nil?

      "<#{@tag_name}#{attributes_string}>#{@content}</#{tag_name}>"
    end

    alias to_s build_tag_string

    def attributes_string
      return '' if @attributes.empty?

      attrs = @attributes.keys.map { |key| @attributes[key].nil? ? key : "#{key}=\"#{@attributes[key]}\"" }.join(' ')
      " #{attrs}"
    end
  end
end
