# frozen_string_literal: true

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  autoload(:VERSION, 'hexlet_code/version')
  autoload(:Tag, 'hexlet_code/tag')
  autoload(:Form, 'hexlet_code/form')

  def self.form_for(entity, url: '#', &block)
    form = Form.new(entity, url)
    return '' unless block_given?

    block.call(form)
    form.build
  end
end
