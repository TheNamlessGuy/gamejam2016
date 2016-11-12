require './player.rb'
require './map.rb'
require './enemies/moneygolem.rb'
require './hitbox.rb'

class PlayState
  def initialize
    @player = Player.new(368, 400)
    @bullets = []
    @map = Map.new
    @map.loadmap("de_dust2.rb")

    @enemies = []
    #@enemies = @map.getobjectlist
    @enemies.push(MoneyGolem.new(500, 435, :e, 200))
  end

  def update(delta)
    @player.update(@bullets, delta)
    if @player.dead
      puts "u ded sonny"
      @player.hitbox.get[0] = 100
      @player.hitbox.get[1] = 400
      @player.dead = false
    end
    
    @bullets.each do |bullet|
      bullet.update(delta)
      if bullet.isGone
        @bullets.delete(bullet)
      end
    end
    
    @enemies.each do |enemy|
      enemy.update(delta)
    end
    
    handlecollisions
  end

  def draw
    @map.draw(@player.hitbox.get[0] - 368, 0)
    @bullets.each do |bullet|
      bullet.draw
    end
    @enemies.each do |enemy|
      enemy.draw(@player.hitbox.get[0] - 368)
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
    
    @enemies.each do |enemy|
      @bullets.each do |bullet|
        puts hitboxcollisioncheck(bullet.hitbox, enemy.hitbox).collided
        if hitboxcollisioncheck(bullet.hitbox, enemy.hitbox).collided
          @enemies.delete(enemy)
          @bullets.delete(bullet)
        end
      end
    end
  end
end
