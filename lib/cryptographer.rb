class Cryptographer
  CHAR_MAP = [*('a'..'z'), *('0'..'9'), ' ', '.', ',']

  attr_accessor :message, :date_offset
  attr_reader :key

  def initialize(user_inputs)
    @message = user_inputs[0]
    @key = user_inputs[1]
    @date_offset = user_inputs[2]
  end

  def generate_cryptograph_key
    key.set_rotation_key
    date_offset.generate_offset

    key.rotation_key.zip(date_offset.offset).map do
      |pair| pair.compact.inject(:+)
    end
  end

  def generate_message_char_indices
    message.chars.map do |char|
      CHAR_MAP.index(char)
    end
  end

  def generate_encryption_indices
    message_indices = generate_message_char_indices
    encryption_key = generate_cryptograph_key

    new_indices = []
    message_indices.each_slice(4) do |slice|
      4.times do |i|
        unless slice[i].nil?
          new_indices << slice[i] + encryption_key[i]
        end
      end
    end

    new_indices
  end

  def indices_for_char_map(indices)
    indices.map { |i| i % 39 }
  end

  def encrypt
    indices = indices_for_char_map(generate_encryption_indices)
    indices.map { |i| CHAR_MAP[i] }.join
  end

  def generate_decryption_indices
    message_indices = generate_message_char_indices
    encryption_key = generate_cryptograph_key

    new_indices = []
    message_indices.each_slice(4) do |slice|
      4.times do |i|
        unless slice[i].nil?
          new_indices << slice[i] - encryption_key[i]
        end
      end
    end

    new_indices
  end

  def decrypt
    indices = indices_for_char_map(generate_decryption_indices)
    indices.map { |i| CHAR_MAP[i] }.join
  end

end
