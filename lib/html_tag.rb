# frozen_string_literal: true

module HexletCode
  class HtmlTag
    attr_reader :tag_name, :attributes, :content

    def initialize(tag_name, attributes = {}, content: '')
      @tag_name = tag_name
      @attributes = attributes
      @content = content
    end

    def build_tag_string
      return "<#{@tag_name}#{attributes_string}>" if content.empty?

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
