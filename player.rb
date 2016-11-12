require './hitbox.rb'

class Player
  attr_accessor :hitbox
  
  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 64, 64)
    @xVel = 0.75
    @yVel = 0

    @ir = :e
    @aimdir = :none
    
    @jumping = false

    @animationCooldown = 100
    @animationIndex = 0
    @@move_w = [Gosu::Image.new("res/player_move_w_1.png"),
                Gosu::Image.new("res/player_move_w_2.png")]
    @@move_e = [Gosu::Image.new("res/player_move_e_1.png"),
                Gosu::Image.new("res/player_move_e_2.png")]
    @toDraw = @@move_e
  end

  def update(bullets, delta)
    @aimdir = @dir
    @animationCooldown -= delta
    
    # Movement
    if Gosu::button_down? Gosu::KbRight
      # Move right
      @hitbox.get[0] += @xVel * delta
      @dir = :e
      @aimdir = @dir
      
      if @toDraw != @@move_e
        changeAnim(@@move_e)
      end
    elsif Gosu::button_down? Gosu::KbLeft
      # Move left
      @hitbox.get[0] -= @xVel * delta
      @dir = :w
      @aimdir = @dir
      
      if @toDraw != @@move_w
        changeAnim(@@move_w)
      end
    else
      # Not moving
    end

    # Aiming
    if Gosu::button_down? Gosu::KbDown
      # Aim down
      if Gosu::button_down? Gosu::KbRight
        @aimdir = :se
      elsif Gosu::button_down? Gosu::KbLeft
        @aimdir = :sw
      else
        @aimdir = :s
      end
    end
    if Gosu::button_down? Gosu::KbUp
      # Aim up
      if Gosu::button_down? Gosu::KbRight
        @aimdir = :ne
      elsif Gosu::button_down? Gosu::KbLeft
        @aimdir = :nw
      else
        @aimdir = :n
      end
    end

    # Shoot
    if Gosu::button_down? Gosu::KbX
      puts "shoot in direction: #{@aimdir.to_s}"
    end
    # Jump
    if Gosu::button_down? Gosu::KbZ
      if @jumping and @yVel > 0.3
        # Float
        @yVel = 0.3
      elsif not @jumping
        # Start jumping
        @jumping = true
        @yVel = -2
      end
    end

    # Move in Y
    @yVel += 0.1
    @hitbox.get[1] += @yVel * delta
    if (@hitbox.get[1] >= 435)
      @jumping = false
      @hitbox.get[1] = 435
      @yVel = 0
    end

    # Change animation frame
    if @animationCooldown <= 0
      @animationIndex = (@animationIndex + 1) % @toDraw.count
      @animationCooldown = 100
    end
  end

  def draw
    @toDraw[@animationIndex].draw(@hitbox.get[0], @hitbox.get[1], 1, 0.64, 0.64)
  end

  def changeAnim(newAnim)
    @toDraw = newAnim
    @animationIndex = 0
    @animationCooldown = 100
  end
end
