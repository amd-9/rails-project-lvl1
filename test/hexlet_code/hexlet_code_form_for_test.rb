# frozen_string_literal: true

require 'test_helper'
require_relative '../fixtures/user'

class HexletCodeTest < Minitest::Test
  def test_form_for
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = File.read("#{__dir__}/../fixtures/form_with_default_action_path.html")

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal expected, form
  end

  def test_form_for_with_url
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = File.read("#{__dir__}/../fixtures/form.html")

    form = HexletCode.form_for user, url: '/users' do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal expected, form
  end

  def test_form_for_with_submit_button
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = File.read("#{__dir__}/../fixtures/form_with_submit.html")

    form = HexletCode.form_for user, url: '/users' do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
      f.submit
    end
    assert_equal expected, form
  end
end
