require "./player.rb"

def objectcreator(x, y, type)
  case type
  when :PLAYER
    return Player.new(x, y)
  else
    puts "INVALID OBJECT TYPE: ", type
  end
  return nil
end
