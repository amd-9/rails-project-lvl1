# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'form'

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  autoload(:Tag, 'tag')

  def self.form_for(entity, url: '#', &block)
    form = Form.new(entity, url)
    return '' unless block_given?

    block.call(form)
    form.to_s
  end
end
