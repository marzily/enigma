require './lib/date_offset'
require './lib/cryptographer'


# def initialize(user_inputs)
#   @message = user_inputs[0]
#   @key = user_inputs[1]
#   @date_offset = user_inputs[2]
# end


class Crack
  CHAR_MAP = [*('a'..'z'), *('0'..'9'), ' ', '.', ',']

  attr_reader :encrypted_message, :date_offset, :decrypted_message

  def initialize(user_inputs)
    @encrypted_message = user_inputs[0]
    @date_offset = DateOffset.new(user_inputs[1])

    @decrypted_message = '..end..'
  end

  def decrypted_message_indices
    decrypted_message.chars.map do |char|
      CHAR_MAP.index(char)
    end
  end

  def sample_message
    encrypted_message[-7..-1]
  end

  def create_date_offsets
    date_offset.generate_offset
  end

  def find_indices
    indices = []
    sample_message.each_char do |char|
      indices << CHAR_MAP.index(char)
    end
    indices
  end

  def encrypted_indices_less_date_offset
    date_offset_nums = create_date_offsets

    new_indices = []
    find_indices.each_slice(4) do |slice|
      4.times do |i|
        unless slice[i].nil?
          new_indices << slice[i] - date_offset_nums[i]
        end
      end
    end

    new_indices
  end

  def crack
    search_key = '00000'
    user_inputs = [sample_message, search_key, @date_offset]
    message = Cryptographer.new(user_inputs).decrypt

    until message == '..end..'

      search_key_ints = search_key.chars.map(&:to_i)

      i = 0
      while i < search_key_ints.length


          9.times do |j|
            search_key_ints[i] = j
            search_key = search_key_ints.map(&:to_s).join
            user_inputs = [sample_message, search_key, @date_offset]

            message = Cryptographer.new(user_inputs).decrypt

          end



        i += 1
      end


    end
    search_key

  end






  def rotate
    key.chars.each_cons(2) do |pair|
      rotation_key << pair.join.to_i
    end
  end



# return decoded message
end
