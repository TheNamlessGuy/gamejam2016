require "gosu"

require './hitbox.rb'

class Particle
  attr_accessor :hitbox, :type
  def initialize(x, y, w, h, type)
    @xVel = (rand() * 2.5) - 1.25413
    @yVel = -rand() * 2.3
    @type = type

    @hitbox = HitBox.new(x, y, w, h)
    @images = [Gosu::Image.new("res/particle_" + type + "1.png"),
                Gosu::Image.new("res/particle_" + type + "2.png")]
    @animationIndex = 0
    @animationCooldown = 70

    @gravity = 1
    if type == "bill"
      @gravity = 0.8
    end
  end

  def update(delta)
    @yVel += 0.1 * @gravity
    @xVel *= 0.95
    @hitbox.get[0] += @xVel * delta
    @hitbox.get[1] += @yVel * delta

    @animationCooldown -= delta
    if @animationCooldown <= 0
      @animationCooldown = 70
      @animationIndex = (@animationIndex + 1) % @images.count
    end
  end

  def draw(camX)
    @images[@animationIndex].draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end
end
