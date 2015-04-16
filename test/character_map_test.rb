gem 'minitest'
require 'minitest/autorun'
require './lib/character_map'

class CharacterMapTest < Minitest::Test

  def test_it_has_a_character_map_class
    map = CharacterMap.new
    assert_instance_of CharacterMap, map
  end

  def test_it_has_a_character_map
    map = CharacterMap.new
    char_map = [*('a'..'z'), *('0'..'9'), ' ', '.', ',']
    assert_equal char_map, CharacterMap::CHAR_MAP
  end
  
end
