gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/user_interface'
require './lib/key'
require './lib/date_offset'

class UserInterfaceTest < Minitest::Test
# ['gqhh,u5l5ao3', '25326', '140415']
# "sample text."
  def setup
    @user_test = UserInterface.new
    @user_test.read_file = "./lib/message.txt"
    @user_test.write_file = "./lib/encrypted.txt"
    @user_test.key_string = '25326'
    @user_test.date_string = '140415'
  end

  def test_it_reads_from_a_file
    assert_equal 'sample text.', @user_test.text_from_file
  end

  def test_it_produces_an_encrypted_message
    assert_equal 'gqhh,u5l5ao3', @user_test.change_message
  end

  def test_it_saves_an_changed_message_to_file
    @user_test.write_to_file
    encrypted = File.open(@user_test.write_file)
    encrypted_message = encrypted.read.delete("\n")
    encrypted.close
    assert_equal 'gqhh,u5l5ao3', encrypted_message


    @user_test.read_file = "./lib/encrypted.txt"
    @user_test.write_file = "./lib/decrypted.txt"
    @user_test.write_to_file
    decrypted = File.open(@user_test.write_file)
    decrypted_message = decrypted.read.delete("\n")
    decrypted.close
    assert_equal 'sample text.', decrypted_message
  end

  def test_it_knows_if_initial_message_is_encrypted
    assert_equal false, @user_test.read_file_encrypted?

    @user_test.read_file = "./lib/encrypted.txt"
    assert @user_test.read_file_encrypted?
  end

  def test_it_decrypts_a_message
    @user_test.read_file = "./lib/encrypted.txt"
    assert_equal 'sample text.', @user_test.change_message
  end

end
