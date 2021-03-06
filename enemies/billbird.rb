require './hitbox.rb'

class BillBird
  attr_accessor :hitbox

  def initialize(x, y, dir, distance)
    @hitbox = HitBox.new(x, y, 64, 64)
    @dir = dir
    @distance = distance
    @distRemaining = distance
    @speed = 0.1
    @diving = false
    
    @@move_e = [Gosu::Image.new("res/billbird_w_1.png"),
                Gosu::Image.new("res/billbird_w_2.png")]
    @@move_w = [Gosu::Image.new("res/billbird_w_1.png"),
                Gosu::Image.new("res/billbird_w_2.png")]
    
    @animationCooldown = 250
    @animationIndex = 0

    @phasedisplacement = rand() * 20000

    if @dir == :e
      @toDraw = @@move_e
    else
      @toDraw = @@move_w
    end
  end

  def update(delta)
    oldX = @hitbox.get[0]

    if @dir == :e
      @hitbox.get[0] += @speed * delta
      if @toDraw != @@move_e
        changeAnim(@@move_e)
      end
    else
      @hitbox.get[0] -= @speed * delta
      if @toDraw != @@move_w
        changeAnim(@@move_w)
      end
    end
    
    @hitbox.get[1] = (Math.sin(Gosu::milliseconds / 200.0) * 50) + ((Math.sin((Gosu::milliseconds + @phasedisplacement) / 4000.0) ** 40) * 400).abs

    @distRemaining -= (oldX - @hitbox.get[0]).abs
    if @distRemaining <= 0
      @dir = (@dir == :e ? :w : :e)
      @distRemaining = @distance
    end

    @animationCooldown -= delta
    if @animationCooldown <= 0
      @animationIndex = (@animationIndex + 1) % @toDraw.count
      @animationCooldown = 250
    end
  end
  
  def draw(camX)
    @toDraw[@animationIndex].draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end

  def changeAnim(newAnim)
    @toDraw = newAnim
    @animationIndex = 0
    @animationCooldown = 250
  end
end
