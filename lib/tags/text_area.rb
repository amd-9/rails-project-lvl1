# frozen_string_literal: true

require_relative '../html_tag'

module HexletCode
  class TextArea
    attr_accessor :name, :attributes, :content

    def initialize(attributes = {}, content = '')
      @name = attributes[:name]
      @attributes = attributes
      @content = content
    end

    def to_s
      text_area_attributes = { cols: 20, rows: 40, **@attributes }
      text_area_tag = HtmlTag.new('textarea', text_area_attributes, content: @content)

      label_attributes = { for: @name }
      label_tag = HtmlTag.new('label', label_attributes, content: @name.capitalize)
      "#{label_tag}\n#{text_area_tag}"
    end
  end
end
