class DateOffset
  attr_accessor :date, :offset

  def initialize(date = generate)
    @date = date
    @offset = []
  end

  def generate
    Time.new.strftime("%d%m%y")
  end

  def valid_characters?
    date.chars.all? { |char| char.to_i.to_s == char }
  end

  def valid_length?
    date.length == 6
  end

  def valid_date?
    if valid_characters? && valid_length?
      day = date[0..1].to_i
      month = date[2..3].to_i
      year = ("20" + date[4..5]).to_i

      Time.new(year, month, day)
      return true
    end
    false
  end

  def square
    date.to_i ** 2 if valid_date?
  end

  def generate_offset
    self.offset = square.to_s.chars[-4..-1].map(&:to_i)
  end

end
