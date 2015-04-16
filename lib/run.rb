require './lib/key'
require './lib/date_offset'
require './lib/cryptographer'

class Run
  attr_accessor :user_inputs

  def initialize(user_inputs)
    @user_inputs =
    [user_inputs[0], Key.new(user_inputs[1]), DateOffset.new(user_inputs[2])]
  end

  def message_valid?
    user_inputs[0].is_a?(String)
  end

  def reset_message
    self.user_inputs[0] = "" unless message_valid?
  end

  def encrypt
    Cryptographer.new(@user_inputs).encrypt
  end

  def decrypt
    Cryptographer.new(@user_inputs).decrypt
  end

end
