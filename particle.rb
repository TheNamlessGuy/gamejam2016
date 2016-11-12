require "gosu"

require './hitbox.rb'

class Particle
  def initialize(x, y, w, h, image)
    @xVel = (rand() * 2.5) - 1.25413
    @yVel = -rand() * 2.3
    @lifetime = 1000


    @hitbox = HitBox.new(x, y, w, h)
    @@images = [Gosu::Image.new(image + "1.png"),
                Gosu::Image.new(image + "2.png")]
    @animationIndex = 0
    @animationCooldown = 70
  end

  def update(delta)
    @yVel += 0.1
    @xVel *= 0.95
    @hitbox.get[0] += @xVel * delta
    @hitbox.get[1] += @yVel * delta
    @lifetime -= delta

    @animationCooldown -= delta
    if @animationCooldown <= 0
      @animationCooldown = 70
      @animationIndex = (@animationIndex + 1) % @@images.count
    end
    
    #if @hitbox.get[1]+@hitbox.get[3] >= 500
    #  @yVel = 0
    #  @hitbox.get[1] = 500 - @hitbox.get[3]
    #end
  end

  def draw(camX)
    @@images[@animationIndex].draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end

  def dead?
    return @lifetime <= 0
  end
end
