require './hitbox.rb'

class BossBag
  attr_accessor :hitbox, :yVel, :activated

  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 25, 25)
    @yVel = 0
    @activated = false

    @jumpCooldown = 2000
    @jumping = false

    @landTimer = 0

    @@images = [Gosu::Image.new('res/bossbag.png'), # normal
                Gosu::Image.new('res/bossbag1.png'), # land
                Gosu::Image.new('res/bossbag2.png')] # jump
    @toDraw = @@images[0]
  end

  def update(delta)
    if not @activated
      #return
    end
    
    @landTimer -= delta
    if @landTimer <= 0 and not @jumping
      @toDraw = @@images[0]
    end

    @jumpCooldown -= delta
    if @jumpCooldown <= 0 and not @jumping and @landTimer <= 0
      @toDraw = @@images[2]
      @jumping = true
      @yVel = -0.75
    end

    #@yVel += 0.1
    #@hitbox.get[1] += @yVel * delta
  end

  def draw(camX)
    @toDraw.draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end

  def landed
    @jumping = false
    @landTimer = 1000
    @jumpCooldown = 1500
    @toDraw = @@images[1]
  end
end
