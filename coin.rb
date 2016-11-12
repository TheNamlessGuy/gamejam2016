require './hitbox.rb'

class Coin
  attr_accessor :hitbox, :value

  def initialize(x, y)
    @yVel = 0
    
    @hitbox = HitBox.new(x, y, 25, 25)
    @@image = Gosu::Image.new("res/coins.png")
    @value = 10
  end

  def update(delta)
    @yVel += 0.1
    @hitbox.get[1] += @yVel * delta
    if @hitbox.get[1]+@hitbox.get[3] >= 500
      @yVel = 0
      @hitbox.get[1] = 500 - @hitbox.get[3]
    end
  end

  def draw(camX)
    @@image.draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end
end
