require './hitbox.rb'

class Coin
  attr_accessor :hitbox, :value

  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 25, 25)
    @@image = Gosu::Image.new("res/coins.png")
    @value = 10
  end

  def update(delta)
    
  end

  def draw(camX)
    @@image.draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end
end
