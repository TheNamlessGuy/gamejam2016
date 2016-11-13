require './hitbox.rb'

class Coin
  attr_accessor :hitbox, :value, :yVel

  def initialize(x, y, type)
    @yVel = -0.5
    
    @hitbox = HitBox.new(x, y, 16, 16)#25, 25)
    @image = Gosu::Image.new("res/" + type + ".png")
    @value = (type == "bill" ? 20 : 10)
  end

  def update(delta)
    @yVel += 0.05
    @hitbox.get[1] += @yVel * delta
  end

  def draw(camX)
    @image.draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end
end
