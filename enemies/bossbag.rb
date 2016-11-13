require './hitbox.rb'

class BossBag
  attr_accessor :hitbox, :yVel, :activated, :jumping

  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 300, 400)
    @yVel = 0
    @activated = false

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
  end

  def draw(camX)
    @toDraw.draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end

  def landed
    if not @activated or not @jumping or @landTimer > 0
      return
    end

    @jumping = false
    @landTimer = 500
    @jumpCooldown = 1500
#    @toDraw = @@images[1]
    @yVel = 0
  end

  def spawnShit(enemies)
    if @landTimer > 0 or not @activated or @jumping
      return
    end

    if [true, false].sample
      enemies.push(MoneyGolem.new(@hitbox.get[0], @hitbox.get[1], :w, 1000))
    else
      enemies.push(BillBird.new(@hitbox.get[0], @hitbox.get[1], :w, 1000))
    end
  end
end
