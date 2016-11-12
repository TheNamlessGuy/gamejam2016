require './hitbox.rb'
require './bullets.rb'

class Player
  attr_accessor :hitbox, :xVel, :yVel
  
  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 64, 64)
    @xVel = 0.75
    @yVel = 0

    @dir = :e
    @aimdir = :none
    @shootCooldown = 250
    
    @jumping = false

    @animationCooldown = 100
    @animationIndex = 0
    @@idle_w = [Gosu::Image.new("res/player_move_w_1.png")]
    @@idle_e = [Gosu::Image.new("res/player_move_e_1.png")]
    @@move_w = [Gosu::Image.new("res/player_move_w_1.png"),
                Gosu::Image.new("res/player_move_w_2.png")]
    @@move_e = [Gosu::Image.new("res/player_move_e_1.png"),
                Gosu::Image.new("res/player_move_e_2.png")]

    @@gun_e = Gosu::Image.new("res/gun_e.png")
    @@gun_w = Gosu::Image.new("res/gun_w.png")

    @toDraw = @@move_e
    @gun = @@gun_e
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
        @gun = @@gun_e
      end
    elsif Gosu::button_down? Gosu::KbLeft
      # Move left
      @hitbox.get[0] -= @xVel * delta
      @dir = :w
      @aimdir = @dir
      
      if @toDraw != @@move_w
        changeAnim(@@move_w)
        @gun = @@gun_w
      end
    else
      # Not moving
      if @dir == :w and @toDraw != @@idle_w
        changeAnim(@@idle_w)
      elsif @dir == :e and @toDraw != @@idle_e
        changeAnim(@@idle_e)
      end
    end

    # Aiming
    if Gosu::button_down? Gosu::KbDown
      # Aim down
      if @jumping
        @aimdir = :s
      else
        @aimdir = :none
      end
    end
    if Gosu::button_down? Gosu::KbUp
      # Aim up
      @aimdir = :n
    end

    # Shoot
    if Gosu::button_down? Gosu::KbX and @shootCooldown <= 0 and @aimdir != :none
      bullets.push(Bullet.new(@hitbox.get[0] + (@hitbox.get[2] / 2.0),
                              @hitbox.get[1] + (@hitbox.get[3] / 2.0),
                              @aimdir))
      @shootCooldown = 250
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

    # Shoot cooldown
    @shootCooldown -= delta

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
    draw_gun
  end

  def draw_gun
    x, y = [@hitbox.get[0], @hitbox.get[1] + 35]
    angle, x = case @aimdir
            when :w
              [0.0, x + 20]
            when :e
              [0.0, x + 42]
            when :s
              [(@dir == :e ? 90.0 : 270.0), x + 32]
            when :n
              [(@dir == :e ? 270.0 : 90.0), x + 32]
            when :none
              [0.0, (@dir == :e ? x + 42 : x + 20)]
    end
    @gun.draw_rot(x, y, 1, angle, 0.5, 0.5, 0.64, 0.64)
  end

  def changeAnim(newAnim)
    @toDraw = newAnim
    @animationIndex = 0
    @animationCooldown = 100
  end
end
