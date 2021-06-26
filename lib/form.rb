# frozen_string_literal: true

require_relative "simple_tag"
require_relative "pair_tag"

class Form
  attr_reader :url, :entity, :inputs

  def initialize(entity, url)
    @url = url
    @entity = entity
    @inputs = []
  end

  def generate_input(name, value, type, input_options = nil)
    tag_type_map = {
      default: -> { SimpleTag.new("input", type: "text", value: value, name: name, input_options) },
      label: -> { PairTag.new("label", { for: name }, content: name.capitalize) },
      text: -> { PairTag.new("textarea", { cols: input_options[:cols] || 20, rows: input_options[:rows] || 40, name: name }, content: value) },
      submit: -> { SimpleTag.new("input", type: "sumbit", value: value) },
      select: lambda do
        option_collection = input_options[:collection]
        select_options = option_collection.map do |option|
          option_tag = if value == option
                         PairTag.new("option", { value: option, selected: nil }, content: option)
                       else
                         PairTag.new("option", { value: option }, content: option)
                       end
          option_tag.to_s
        end
        PairTag.new("select", { name: name }, content: "\n#{select_options.join("\n")}\n")
      end
    }

    input_tag = tag_type_map[type].call
    input_tag.to_s
  end

  def input(property, as: :default, **kwargs)
    input_with_labels_map = %i(default text) 
    @inputs << generate_input(property, nil, :label) if input_with_labels_map.include? as
    @inputs << generate_input(property, @entity[property], as, kwargs)
  end

  def submit(button_name = "Save")
    @inputs << generate_input("commit", button_name, :submit)
  end

  def to_s
    inputs_string = @inputs.map(&:to_s).join("\n")
    "<form action=\"#{@url}\" method=\"post\">\n#{inputs_string}\n</form>"
  end
end
