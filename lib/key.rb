class Key
  attr_accessor :key, :rotation_key

  def initialize(key = nil)
    @key = key.nil? ? generate : key
    @rotation_key = []
  end

  def generate
    new_key = ""
    5.times { new_key << rand(9).to_s }
    new_key
  end

  def valid_length?
    key.length == 5
  end

  def valid_characters?
    key.chars.all? { |char| char.to_i.to_s == char }
  end

  def valid?
    valid_length? && valid_characters?
  end

  def rotate
    key.chars.each_cons(2) do |pair|
      rotation_key << pair.join.to_i
    end
  end

  def set_key
    self.key = generate
  end

  def set_rotation_key
    set_key unless valid?
    rotate
  end
  # this is the only method you need to call from Key class

end
