gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/crack'
require './lib/key'
require './lib/cryptographer'


class CrackTest < Minitest::Test

  def setup
    @message = "sample text...end.."
    @encrypted = Crack.new(["gqhh,u5l5ao3zo,f4o6", '140415'])
  end

  def test_it_has_a_date_offset_object
    assert_instance_of DateOffset, @encrypted.date_offset
  end

  def test_it_saves_last_7_characters_from_encrypted_message
    assert_equal "zo,f4o6", @encrypted.sample_message
  end

  def test_it_generates_date_offset_keys
    assert_equal [2, 2, 2, 5], @encrypted.create_date_offsets
  end

  def test_it_finds_indices
    indices = [25, 14, 38, 5, 30, 14, 32]
    assert_equal indices, @encrypted.find_indices
  end

  def test_it_maps_indices_for_decryped_message
    indices = [37, 37, 4, 13, 3, 37, 37]
    assert_equal indices, @encrypted.decrypted_message_indices
  end

  def test_decrypted_message_indices_with_rotation_keys
    indices = [23, 12, 36, 0, 28, 12, 30]
    assert_equal indices, @encrypted.encrypted_indices_less_date_offset
  end


  def test_it_cracks_encrypted_message
    skip
    keys = @encrypted.crack




  end

  def test_it_finds_rotation_keys
    skip
    @encrypted.find_key
    assert_equal "..end..", @encrypted.decrypt
  end

  def test_it_decrypts_sample_message
    skip
    assert_equal "..end..", @encrypted.decrypt
  end

end
