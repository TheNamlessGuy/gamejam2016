require './hitbox.rb'
require './gosu_facade.rb'

class Bullet
  attr_accessor :hitbox, :isGone

  def initialize(x, y, direction)
    moveSpeed = 1.5
    @angle, @xMove, @yMove, w = case direction
      when :w
               [180.0, -moveSpeed, 0, true]
      when :e
               [0.0, moveSpeed, 0, true]
      when :s
               [90.0, 0, moveSpeed, false]
      when :n
               [270.0, 0, -moveSpeed, false]
    end

    if w
      @hitbox = HitBox.new(x, y, 40, 5)
    else
      @hitbox = HitBox.new(x, y, 5, 40)
    end
    @@image = Gosu::Image.new("res/bullet.png")
  end

  def update(delta)
    @hitbox.get[0] += @xMove * delta
    @hitbox.get[1] += @yMove * delta
  end

  def draw(camX)
    @@image.draw_rot(@hitbox.get[0] - camX, @hitbox.get[1], 1, @angle)
#x    gosu_draw_rect_from_hitbox(@hitbox, 0xff0000ff, 9)
  end
end
