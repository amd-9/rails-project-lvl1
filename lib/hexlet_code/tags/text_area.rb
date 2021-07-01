# frozen_string_literal: true

module HexletCode
  module Tags
    class TextArea
      attr_accessor :name, :attributes, :content

      autoload(:Tag, 'hexlet_code/Tag')

      def initialize(attributes = {}, content = '')
        @name = attributes[:name]
        @attributes = attributes
        @content = content
      end

      def to_s
        text_area_attributes = { cols: 20, rows: 40, **@attributes }
        text_area_tag = HexletCode::Tag.new('textarea', text_area_attributes) { @content }

        label_attributes = { for: @name }
        label_tag = HexletCode::Tag.new('label', label_attributes) { @name.capitalize }
        "#{label_tag}\n#{text_area_tag}"
      end
    end
  end
end
