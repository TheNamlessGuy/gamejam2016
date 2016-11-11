class Player
  def initialize(x, y)
    @x = x
    @y = y
    @xVel = 1
    @yVel = 0

    @ir = :e
    @aimdir = :none
    
    @jumping = false

    @@image = Gosu::Image.new("res/player.png")
  end

  def update(bullets, delta)
    @aimdir = @dir
    if Gosu::button_down? Gosu::KbRight
      # Move right
      @x += @xVel * delta
      @dir = :e
      @aimdir = @dir
    end
    if Gosu::button_down? Gosu::KbLeft
      # Move left
      @x -= @xVel * delta
      @dir = :w
      @aimdir = @dir
    end
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
    if Gosu::button_down? Gosu::KbX then
      # Shoot
      puts "shoot in direction: #{@aimdir.to_s}"
    end
    if Gosu::button_down? Gosu::KbZ and not @jumping then
      # Jump
      @jumping = true
      @yVel = -2
    end

    @yVel += 0.1
    @y += @yVel * delta
    if (@y >= 435)
      @jumping = false
      @y = 435
    end
  end

  def draw
    @@image.draw(@x, @y, 1)
  end
end
