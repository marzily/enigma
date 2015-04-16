gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/run'
require './lib/key'
require './lib/date_offset'

class RunTest < Minitest::Test

  def setup
    user_inputs = [nil, nil, nil]
    @run_test = Run.new(user_inputs)
  end

  def test_it_has_a_run_class
    assert_instance_of Run, @run_test
  end

  def test_message_is_valid
    assert_equal false, @run_test.message_valid?

    user_inputs = [0, nil, nil]
    run_test2 = Run.new(user_inputs)
    assert_equal false, run_test2.message_valid?

    user_inputs = ["hello", nil, nil]
    run_test3 = Run.new(user_inputs)
    assert run_test3.message_valid?, "Message must be a string!"
  end

  def test_ensure_message_is_valid
    user_inputs = [0, nil, nil]
    run_test2 = Run.new(user_inputs)
    run_test2.reset_message
    assert_equal "", run_test2.user_inputs[0]
  end

  def test_it_has_a_key_object
    assert_instance_of Key, @run_test.user_inputs[1]
  end

  def test_it_has_a_date_offset_object
    assert_instance_of DateOffset, @run_test.user_inputs[2]
  end

  def test_it_encrypts_a_message
run_test2 = Run.new(['sample text.', '25326', '140415'])
    assert_equal 'gqhh,u5l5ao3', run_test2.encrypt

    run_test3 = Run.new(['persoenlichkeit', '25326', '140415'])
    assert_equal "dumkcuid9scc5yo", run_test3.encrypt
  end

  def test_it_decrypts_a_message
    run_test2 = Run.new(['gqhh,u5l5ao3', '25326', '140415'])
    assert_equal 'sample text.', run_test2.decrypt

    run_test3 = Run.new(['dumkcuid9scc5yo', '25326', '140415'])
    assert_equal 'persoenlichkeit', run_test3.decrypt
  end

end
