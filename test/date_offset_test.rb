gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/date_offset'

class DateOffsetTest < Minitest::Test

  def test_it_has_a_date_offsets_class
    test_date = DateOffset.new
    assert_instance_of DateOffset, test_date
  end

  def test_it_optionally_takes_a_date_when_instantiated
    test_date = DateOffset.new('020315')
    assert_equal '020315', test_date.date
  end

  def test_it_sets_date_if_date_is_not_provided
    test_date = DateOffset.new
    assert_equal Time.new.strftime("%d%m%y"), test_date.date
  end

  def test_date_has_valid_characters
    test_date = DateOffset.new('hello')
    assert_equal false, test_date.valid_characters?

    test_date1 = DateOffset.new('hell0')
    assert_equal false, test_date1.valid_characters?

    test_date2 = DateOffset.new('030415')
    assert test_date2.valid_characters?
  end

  def test_date_string_is_valid_length
    test_date = DateOffset.new('03041553')
    refute test_date.valid_length?

    test_date = DateOffset.new('030415')
    assert test_date.valid_length?
  end

  def test_invalid_date_raises_error
    test_date = DateOffset.new('031415')
    assert_raises (ArgumentError) { test_date.valid_date? }
  end

  def test_it_has_a_valid_date
    test_date = DateOffset.new('03041553')
    assert_equal false, test_date.valid_date?

    test_date = DateOffset.new('030415')
    assert test_date.valid_date?
  end

  def test_it_squares_valid_datess
    test_date = DateOffset.new('030415')
    assert_equal 925072225, test_date.square

    test_date2 = DateOffset.new('03041590')
    refute test_date2.square
  end

  def test_it_generates_offsets
    test_date = DateOffset.new('020315')

    assert_equal [9, 2, 2, 5], test_date.generate_offset
  end

end
