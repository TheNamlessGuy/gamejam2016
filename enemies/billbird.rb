require '../hitbox.rb'

class BillBird
  attr_accessor :hitbox
  
  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 25, 25)
    
    @@move_w = [Gosu::Image.new("res/billbird_w_1.png"),
                Gosu::Image.new("res/billbird_w_2.png")]

    @animationIndex = 0
    @animationCooldown = 250
    @toDraw = @@move_w

    @@speed = 0.75
  end

  def update(delta)
    @animationCooldown -= delta
    if @animationCooldown <= 0
      @animationCooldown = 250
      @animationIndex = (@animationIndex + 1) % @toDraw
    end

    @hitbox.get[0] += @@speed * delta
  end

  def draw(camX)
    @toDraw[@animationIndex].draw(@hitbox.get[0] - camX, @hitbox.get[1], 1)
  end
end
