# frozen_string_literal: true

require "test_helper"

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_build_simple_tag
    tag = HexletCode::Tag.build("br")
    assert_equal tag, '<br>'
  end

  def test_build_simple_tag_with_attributes
    tag = HexletCode::Tag.build("img", id: "test-image", src: "path/to/image")
    assert_equal tag, "<img id=\"test-image\" src=\"path/to/image\">"
  end

  def test_build_pair_tag
    tag = HexletCode::Tag.build("label") { 'Email' }
    expected = "<label>Email</label>"
    assert_equal tag, expected
  end

  def test_build_pair_tag_with_attributes
    tag = HexletCode::Tag.build('label', for: 'email') { 'Email' }
    expected = "<label for=\"email\">Email</label>"
    assert_equal tag, expected
  end
end
