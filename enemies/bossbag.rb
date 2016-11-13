require './hitbox.rb'
require './gosu_facade.rb'

class BossBag
  attr_accessor :hitbox, :yVel, :activated, :jumping, :weakspot

  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 300, 400)
    @weakspot = HitBox.new(x + 100, y + 150, 100, 70)
    @yVel = 0
    @xVel = 0.5
    @activated = false

    @health = 10
    @dmgCooldown = 0

    @jumpCooldown = 3000
    @jumping = false

    @landTimer = 0

    @@images = [Gosu::Image.new('res/bossbag.png'), # normal
                Gosu::Image.new('res/bossbag1.png'), # land
                Gosu::Image.new('res/bossbag2.png')] # jump
    @toDraw = @@images[0]
  end

  def update(delta)
    if not @activated
      return
    end
    
    @dmgCooldown -= delta
    @landTimer -= delta
    @jumpCooldown -= delta
    if @jumpCooldown <= 0 and not @jumping and @landTimer <= 0
      @jumping = true
      @yVel = -1.5
    end

    if @jumping
      @toDraw = @@images[2]
    elsif @landTimer <= 0 and not @jumping
      @toDraw = @@images[0]
    else
      @toDraw = @@images[1]
    end

    @yVel += 0.1
    @hitbox.get[1] += @yVel * delta

    if @jumping
      @hitbox.get[0] -= @xVel * delta
    end
  end

  def draw(camX)
    @toDraw.draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
    #gosu_draw_rect(@weakspot.get[0] - camX, @weakspot.get[1], @weakspot.get[0] - camX + @weakspot.get[2], @weakspot.get[1] + @weakspot.get[3], 0xffff0000, 9)
  end

  def landed
    if not @activated or not @jumping or @landTimer > 0
      return
    end

    @jumping = false
    @landTimer = 500
    @jumpCooldown = 1500
    @yVel = 0
  end

  def set_weakspot
    @weakspot.get[0] = (@hitbox.get[0] + 100).ceil
    if @toDraw == @@images[1]
      @weakspot.get[1] = (@hitbox.get[1] + 220).ceil
    else
      @weakspot.get[1] = (@hitbox.get[1] + 150).ceil
    end
  end

  def damage
    if @dmgCooldown > 0 or not @activated
      return false
    end
    @health -= 1
    @dmgCooldown = 250
    
    return true
  end

  def dead?
    return @health <= 0
  end
end
