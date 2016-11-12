require './hitbox.rb'
require './bullets.rb'

class Player
  attr_accessor :hitbox, :xSpeed, :jumping, :yVel, :dead, :aimdir
  
  def initialize(x, y)
    @origX = x
    @origY = y
    @hitbox = HitBox.new(x, y, 64, 64)
    @xVel = 0.75
    @yVel = 0
    @xSpeed = 0

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
    @@gliding_w = [Gosu::Image.new("res/player_glide_w_1.png"),
                   Gosu::Image.new("res/player_glide_w_2.png")]
    @@gliding_e = [Gosu::Image.new("res/player_glide_e_1.png"),
                   Gosu::Image.new("res/player_glide_e_2.png")]
    @@fall_w = [Gosu::Image.new("res/player_fall_w_1.png")]
    @@fall_e = [Gosu::Image.new("res/player_fall_e_1.png")]
    @@jump_w = [Gosu::Image.new("res/player_fall_w_1.png")]
    @@jump_e = [Gosu::Image.new("res/player_fall_e_1.png")]

    @@gun_e = Gosu::Image.new("res/gun_e.png")
    @@gun_w = Gosu::Image.new("res/gun_w.png")

    @toDraw = @@move_e
    @gun = @@gun_e

    @dead = false
  end

  def update(delta)
    @aimdir = @dir
    @animationCooldown -= delta
    shot = false
    moved = false
    
    # Movement
    if Gosu::button_down? Gosu::KbRight
      # Move right
      @xSpeed = @xVel
      @hitbox.get[0] += @xSpeed * delta
      @dir = :e
      @aimdir = @dir
      
      moved = true
      @gun = @@gun_e
    elsif Gosu::button_down? Gosu::KbLeft
      # Move left
      @xSpeed = -@xVel
      @hitbox.get[0] += @xSpeed * delta
      @dir = :w
      @aimdir = @dir
      
      moved = true
      @gun = @@gun_w
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
      shot = true
      @shootCooldown = 250
    end
    # Jump
    gliding = false
    if Gosu::button_down? Gosu::KbZ
      if @jumping and @yVel > 0.3
        # Float
        gliding = true
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
    if @hitbox.get[1] > 800
      @dead = true
    end

    # Set animation
    if @yVel > 0 and @jumping
      if gliding
        if @dir == :e and @toDraw != @@gliding_e
          changeAnim(@@gliding_e)
        elsif @dir == :w and @toDraw != @@gliding_w
          changeAnim(@@gliding_w)
        end
      else
        if @dir == :e and @toDraw != @@fall_e
          changeAnim(@@fall_e)
        elsif @dir == :w and @toDraw != @@fall_w
          changeAnim(@@fall_w)
        end
      end
    elsif @yVel < 0
      if @dir == :w and @toDraw != @@jump_w
        changeAnim(@@jump_w)
      elsif @dir == :e and @toDraw != @@jump_e
        changeAnim(@@jump_e)
      end
    elsif @dir == :w
      if moved and @toDraw != @@move_w
        changeAnim(@@move_w)
      elsif not moved and @toDraw != @@idle_w
        changeAnim(@@idle_w)
      end
    elsif @dir == :e
      if moved and @toDraw != @@move_e
        changeAnim(@@move_e)
      elsif not moved and @toDraw != @@idle_e
        changeAnim(@@idle_e)
      end
    end

    # Change animation frame
    if @animationCooldown <= 0
      @animationIndex = (@animationIndex + 1) % @toDraw.count
      @animationCooldown = 100
    end
    
    return shot
  end

  def draw
    @toDraw[@animationIndex].draw(368, @hitbox.get[1], 1, 0.64, 0.64)
    draw_gun
  end

  def draw_gun
    x, y = [368, @hitbox.get[1] + 35]
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

  def reset
    initialize(@origX, @origY)
  end
end
