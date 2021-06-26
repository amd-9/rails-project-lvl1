class SimpleTag
  attr_reader :tag_name, :attributes

  def initialize(tag_name, attributes = {})
    @tag_name = tag_name
    @attributes = attributes
  end

  def to_s
    build_tag_string
  end

  def build_tag_string
    "<#{@tag_name}#{attributes_string}>"
  end

  def attributes_string
    return '' if @attributes.empty?
    
    " " + @attributes.keys.map{ |key| "#{key}=\"#{@attributes[key]}\"" }.join(" ")
  end
end
