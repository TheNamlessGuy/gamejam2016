require './player.rb'
require './map.rb'

class PlayState
  def initialize
    @player = Player.new(100, 400)
    @bullets = []
    @map = Map.new
    @map.loadmap("de_dust2.rb")
  end

  def update(delta)
    @player.update(@bullets, delta)
    @bullets.each do |bullet|
      bullet.update(delta)
      if bullet.isGone
        @bullets.delete(bullet)
      end
    end
    handlecollisions
  end

  def draw
    @map.draw(0, 0)
    @bullets.each do |bullet|
      bullet.draw
    end
    @player.draw
  end

  #PRIVATE (SORTA)
  
  def handlecollisions
    info = @map.collisioncheck(@player.hitbox)
    if info
      case info.direction
      when :e
        @player.hitbox.set(0, info.x - @player.hitbox.get[2])
        @player.xSpeed = 0
      when :w
        @player.hitbox.set(0, info.x)
        @player.xSpeed = 0
      when :n
        @player.hitbox.set(1, info.y)
        @player.yVel = 0
      when :s
        @player.hitbox.set(1, info.y - @player.hitbox.get[3])
        @player.yVel = 0
        @player.jumping = false
      end
    else
      @player.jumping = true
    end
  end
  
end
