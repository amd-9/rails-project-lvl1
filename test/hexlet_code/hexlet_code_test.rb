# frozen_string_literal: true

require 'test_helper'
require_relative '../fixtures/user'

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end
end
