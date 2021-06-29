# frozen_string_literal: true

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  autoload(:VERSION, 'hexlet_code/version')
  autoload(:Tag, 'tag')
  autoload(:Form, 'form')

  def self.form_for(entity, url: '#', &block)
    form = Form.new(entity, url)
    return '' unless block_given?

    block.call(form)
    form.to_s
  end
end
