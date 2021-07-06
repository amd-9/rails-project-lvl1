# frozen_string_literal: true

module HexletCode
  module Tags
    class Select
      attr_accessor :name, :attributes, :options

      autoload(:Tag, 'hexlet_code/Tag')

      def initialize(attributes = {})
        @name = attributes[:name]
        @attributes = attributes.except(:collection)
        @options = attributes[:collection]
      end

      def build
        option_tags = @options.map do |option|
          option_attributes = @attributes[:value] == option ? { selected: nil } : {}
          option_tag = HexletCode::Tag.new('option', { value: option, **option_attributes }) { option }
          option_tag.build
        end

        select_tag = HexletCode::Tag.new('select', @attributes.except(:value)) { "\n#{option_tags.join("\n")}\n" }
        select_tag.build
      end
    end
  end
end
