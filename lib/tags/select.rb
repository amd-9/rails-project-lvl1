# frozen_string_literal: true

require_relative '../html_tag'

module HexletCode
  class Select
    attr_accessor :name, :attributes, :options

    def initialize(attributes = {})
      @name = attributes[:name]
      @attributes = attributes.except(:collection)
      @options = attributes[:collection]
    end

    def to_s
      option_tags = @options.map do |option|
        option_attributes = @attributes[:value] == option ? { selected: nil } : {}
        HtmlTag.new('option', { value: option, **option_attributes }, content: option).to_s
      end

      HtmlTag.new('select', @attributes.except(:value), content: "\n#{option_tags.join("\n")}\n").to_s
    end
  end
end
