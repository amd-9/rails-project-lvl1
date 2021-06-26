# frozen_string_literal: true

class PairTag < SimpleTag
  attr_reader :content

  def initialize(tag_name, attributes = {}, content: '')
    super(tag_name, attributes)
    @content = content
  end

  def build_tag_string
    "<#{@tag_name}#{attributes_string}>#{@content}</#{tag_name}>"
  end
end
