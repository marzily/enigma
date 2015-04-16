gem 'minitest'
require 'minitest/autorun'
require './lib/key'

class KeyTest < Minitest::Test

  def test_it_has_a_key_class
    test_key = Key.new
    assert_instance_of Key, test_key
  end

  def test_it_optionally_takes_a_key_when_instantiated
    test_key = Key.new('12345')
    assert_equal '12345', test_key.key
  end

  def test_key_has_a_length_of_5
    test_key = Key.new('098765')
    assert_equal false, test_key.valid_length?

    test_key1 = Key.new('0987')
    assert_equal false, test_key1.valid_length?

    test_key2 = Key.new('09876')
    assert_equal true, test_key2.valid_length?
  end

  def test_key_has_valid_characters
    test_key = Key.new('hello')
    assert_equal false, test_key.valid_characters?

    test_key1 = Key.new('hell0')
    assert_equal false, test_key1.valid_characters?

    test_key2 = Key.new('12345')
    assert test_key2.valid_characters?
  end

  def test_it_only_takes_valid_keys
    test_key = Key.new('hello world')
    refute test_key.valid?, "Strings are not valid and length is too long!"

    test_key1 = Key.new('12345')
    assert test_key1.valid?
  end

  def test_it_generates_a_random_key
    test_key = Key.new
    assert test_key.valid?
  end

  def test_it_produces_rotation_key
    test_key = Key.new('12345')
    test_key.rotate
    assert_equal [12, 23, 34, 45], test_key.rotation_key
  end

  def test_it_can_set_a_key
    test_key = Key.new('1234')
    test_key.set_key
    assert test_key.valid?
  end

  def test_it_sets_rotation_key
    test_key = Key.new('123')
    test_key.set_rotation_key
    assert test_key.rotation_key.length == 4

    test_key1 = Key.new('12345')
    test_key1.set_rotation_key
    assert test_key1.rotation_key.length == 4
  end

end
