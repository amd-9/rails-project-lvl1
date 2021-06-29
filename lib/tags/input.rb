# frozen_string_literal: true

require_relative '../html_tag'
module HexletCode
  class Input
    attr_accessor :name, :type, :attributes

    def initialize(type = 'text', attributes = {})
      @type = type
      @name = attributes[:name]
      @attributes = attributes
    end

    def to_s
      input_attributes = { type: @type, **@attributes }
      input_tag = HtmlTag.new('input', input_attributes)

      if type == 'submit'
        input_tag.to_s
      else
        label_attributes = { for: @name }
        label_tag = HtmlTag.new('label', label_attributes, content: @name.capitalize)
        "#{label_tag}\n#{input_tag}"
      end
    end
  end
end
