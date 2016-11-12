require './hitbox.rb'

class Bullet
  attr_accessor :hitbox, :isGone

  def initialize(x, y, direction)
    moveSpeed = 1.5
    @angle, @xMove, @yMove = case direction
      when :w
               [180.0, -moveSpeed, 0]
      when :e
               [0.0, moveSpeed, 0]
      when :s
               [90.0, 0, moveSpeed]
      when :n
               [270.0, 0, -moveSpeed]
    end

    @hitbox = HitBox.new(x, y, 40, 40)
    @@image = Gosu::Image.new("res/bullet.png")
    @ttl = 200
    @isGone = false
  end

  def update(delta)
    @hitbox.get[0] += @xMove * delta
    @hitbox.get[1] += @yMove * delta
    @ttl -= delta
    if @ttl <= 0
      @isGone = true
    end
  end

  def draw
    @@image.draw_rot(@hitbox.get[0], @hitbox.get[1], 1, @angle)
  end
end
