gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cryptographer'
require './lib/key'
require './lib/date_offset'

class CryptographerTest < Minitest::Test

  def setup
    @message = 'sample text.'
    @key = Key.new('25326')
    @date_offset = DateOffset.new('140415')

    @cryptographer_test = Cryptographer.new([@message, @key, @date_offset])
  end

  def test_it_has_a_cryptographer_class
    assert_instance_of Cryptographer, @cryptographer_test
  end

  def test_it_has_a_character_map
    characters = [*('a'..'z'), *('0'..'9'), ' ', '.', ',']
    assert_equal characters, Cryptographer::CHAR_MAP
  end

  def test_it_generates_cryptograph_key
    assert_equal [27, 55, 34, 31], @cryptographer_test.generate_cryptograph_key
  end

  def test_it_finds_indices_of_chars_in_message
    indices = [18, 0, 12, 15, 11, 4, 36, 19, 4, 23, 19, 37]
    assert_equal indices, @cryptographer_test.generate_message_char_indices
  end

  def test_it_generates_encryption_indices
    indices = [45, 55, 46, 46, 38, 59, 70, 50, 31, 78, 53, 68]
    assert_equal indices, @cryptographer_test.generate_encryption_indices
  end

  def test_ensure_encryption_indices_in_range
    char_map = [*('a'..'z'), *('0'..'9'), ' ', '.', ',']
    e_i = @cryptographer_test.generate_encryption_indices
    indices = @cryptographer_test.indices_for_char_map(e_i)
    encrypted_chars = indices.map { |i| char_map[i] }

    assert_equal false, encrypted_chars.include?(nil)
  end

  def test_returns_an_empty_string_if_no_message_given
    test = Cryptographer.new(["", @key, @date_offset])
    assert_equal "", test.encrypt
  end

  def test_it_encrypts_a_message
    assert_equal 'gqhh,u5l5ao3', @cryptographer_test.encrypt

    cryptographer_test2 = Cryptographer.new(['persoenlichkeit', @key, @date_offset])
    assert_equal "dumkcuid9scc5yo", cryptographer_test2.encrypt
  end

  def test_it_generates_decryption_indices
    decrypt_test = Cryptographer.new(['gqhh,u5l5ao3', @key, @date_offset])
    indices = [-21, -39, -27, -24, 11, -35, -3, -20, 4, -55, -20, -2]
    assert_equal indices, decrypt_test.generate_decryption_indices
  end

  def test_it_decrypts_a_message
    decrypt_test = Cryptographer.new(['gqhh,u5l5ao3', @key, @date_offset])
    assert_equal 'sample text.', decrypt_test.decrypt

    decrypt_test2 = Cryptographer.new(['dumkcuid9scc5yo', @key, @date_offset])
    assert_equal 'persoenlichkeit', decrypt_test2.decrypt
  end

end
