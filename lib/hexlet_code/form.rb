# frozen_string_literal: true

module HexletCode
  module Tags
    autoload(:Input, 'hexlet_code/tags/input')
    autoload(:TextArea, 'hexlet_code/tags/text_area')
    autoload(:Select, 'hexlet_code/tags/select')
  end

  class Form
    attr_reader :url, :entity, :inputs

    def initialize(entity, url)
      @url = url
      @entity = entity
      @inputs = []
    end

    def generate_input(name, value, type, input_options = {})
      tag_type_map = {
        default: -> { Tags::Input.new('text', { value: value, name: name, **input_options }) },
        text: -> {  Tags::TextArea.new({ name: name, **input_options }, value) },
        submit: -> { Tags::Input.new('submit', { value: value, name: name, **input_options }) },
        select: -> { Tags::Select.new({ name: name, value: value, **input_options }) }
      }

      tag_type_map[type].call.to_s
    end

    def input(property, **kwargs)
      as = kwargs[:as] || :default

      @inputs << generate_input(property, @entity[property], as, kwargs.except(:as))
    end

    def submit(button_name = 'Save')
      @inputs << generate_input('Commit', button_name, :submit)
    end

    def to_s
      inputs_string = @inputs.map(&:to_s).join("\n")
      "<form action=\"#{@url}\" method=\"post\">\n#{inputs_string}\n</form>"
    end
  end
end
