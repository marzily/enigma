require './lib/run'

class UserInterface

  attr_accessor :read_file, :write_file, :key_string, :date_string, :encrypted

  def initialize
    @read_file = ARGV[0]
    @write_file = ARGV[1]
    @key_string = ARGV[2]
    @date_string = ARGV[3]
  end

  def read_file_encrypted?
    @read_file.include?("encrypted.txt")
  end

  def text_from_file
    @opened_read_file = File.open(read_file)
    @opened_read_file.read.delete("\n")
  end

  # def initialize(user_inputs)
    # @user_inputs =
    # [user_inputs[0], Key.new(user_inputs[1]), DateOffset.new(user_inputs[2])]

  def change_message
    user_inputs = [text_from_file, key_string, date_string]
    @opened_read_file.close
    if read_file_encrypted?
      Run.new(user_inputs).decrypt
    else
      Run.new(user_inputs).encrypt
    end

  end

  def write_to_file
    open_write_file = File.open(write_file, 'w')
    new_message = change_message
    open_write_file.puts new_message
    open_write_file.close
  end


end
