# frozen_string_literal: true

require 'test_helper'
require_relative '../fixtures/user'

class HexletCodeTest < Minitest::Test
  def test_form_for
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = %(<form action="#" method="post">
<label for="name">Name</label>
<input type="text" value="rob" name="name">
<label for="job">Job</label>
<textarea cols="20" rows="40" name="job">hexlet</textarea>
<select name="gender">
<option value="m" selected>m</option>
<option value="f">f</option>
</select>
</form>)
    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal expected, form
  end

  def test_form_for_with_url
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = %(<form action="/users" method="post">
<label for="name">Name</label>
<input type="text" value="rob" name="name">
<label for="job">Job</label>
<textarea cols="20" rows="40" name="job">hexlet</textarea>
<select name="gender">
<option value="m" selected>m</option>
<option value="f">f</option>
</select>
</form>)

    form = HexletCode.form_for user, url: '/users' do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal expected, form
  end

  def test_form_for_with_submit_button
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = %(<form action="/users" method="post">
<label for="name">Name</label>
<input type="text" value="rob" name="name">
<label for="job">Job</label>
<textarea cols="20" rows="40" name="job">hexlet</textarea>
<select name="gender">
<option value="m" selected>m</option>
<option value="f">f</option>
</select>
<input type="submit" value="Save" name="Commit">
</form>)

    form = HexletCode.form_for user, url: '/users' do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
      f.submit
    end
    assert_equal expected, form
  end
end
