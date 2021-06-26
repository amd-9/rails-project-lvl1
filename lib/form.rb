# frozen_string_literal: true

require_relative 'simple_tag'
require_relative 'pair_tag'

class Form
  attr_reader :url, :entity, :inputs

  def initialize(entity, url)
    @url = url
    @entity = entity
    @inputs = []
  end

  def generate_input(name, value, type, input_options = {})
    tag_type_map = {
      default: -> { SimpleTag.new('input', type: 'text', value: value, name: name, **input_options) },
      label: -> { PairTag.new('label', { for: name }, content: name.capitalize) },
      text: -> { PairTag.new('textarea', { cols: 20, rows: 40, name: name, **input_options }, content: value) },
      submit: -> { SimpleTag.new('input', type: 'submit', value: value, **input_options) },
      select: -> { PairTag.new('select', { name: name }, content: generate_options(value, input_options[:collection])) }
    }

    tag_type_map[type].call.to_s
  end

  def generate_options(selected_value, options = [])
    selected_options = options.map do |option|
      option_props = selected_value == option ? { selected: nil } : {}
      PairTag.new('option', { value: option, **option_props }, content: option).to_s
    end
    "\n#{selected_options.join("\n")}\n"
  end

  def generate_label(property)
    @inputs << generate_input(property, nil, :label)
  end

  def input(property, **kwargs)
    as = kwargs[:as] || :default

    generate_label property if %i[default text].include? as
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
