# frozen_string_literal: true

module HexletCode
  module Tags
    class Input
      attr_accessor :name, :type, :attributes

      autoload(:Tag, 'hexlet_code/tag')

      def initialize(type = 'text', attributes = {})
        @type = type
        @name = attributes[:name]
        @attributes = attributes
      end

      def to_s
        input_attributes = { type: @type, **@attributes }
        input_tag = HexletCode::Tag.new('input', input_attributes)

        if type == 'submit'
          input_tag.to_s
        else
          label_attributes = { for: @name }
          label_tag = HexletCode::Tag.new('label', label_attributes) { @name.capitalize }
          "#{label_tag}\n#{input_tag}"
        end
      end
    end
  end
end
