require './player.rb'
require './map.rb'
require './enemies/moneygolem.rb'
require './hitbox.rb'

# TODO: Fucking remove this what are you doing stop
require './gosu_facade.rb'

class PlayState
  def initialize
    @player = Player.new(368, 400)
    @bullets = []
    @map = Map.new
    @map.loadmap("de_dust2.rb")

    @enemies = []
    #@enemies = @map.getobjectlist
    @enemies.push(MoneyGolem.new(500, 435, :e, 200))
    
    @money = []
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
    end
    
    @enemies.each do |enemy|
      enemy.update(delta)
    end
    
    handlecollisions
  end

  def draw
    @map.draw(@player.hitbox.get[0] - 368, 0)

    @bullets.each do |bullet|
      bullet.draw(@player.hitbox.get[0] - 368)
    end

    @enemies.each do |enemy|
      enemy.draw(@player.hitbox.get[0] - 368)
    end

    @money.each do |cash|
      cash.draw(@player.hitbox.get[0] - 368)
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
    
    # Enemy hit by bullet / player in contact
    @enemies.each do |enemy|
      @bullets.each do |bullet|
        if hitboxcollisioncheck(bullet.hitbox, enemy.hitbox).collided
          enemy.onDeath(@money)
          @enemies.delete(enemy)
          @bullets.delete(bullet)
        end
      end
      
      if hitboxcollisioncheck(enemy.hitbox, @player.hitbox).collided
        @player.dead = true
      end
    end
   
    # Bullet hit ground or off screen
    @bullets.each do |bullet|
      info = @map.collisioncheck(bullet.hitbox)
      if not info.nil? and info.collided
        @bullets.delete(bullet)
      elsif bullet.hitbox.get[1] <= 0 or bullet.hitbox.get[1] >= 600 or
          bullet.hitbox.get[0] >= 800 or bullet.hitbox.get[0] <= 0
        @bullets.delete(bullet)
      end
    end
    
    # Player picking up money
    @money.each do |cash|
      if hitboxcollisioncheck(cash.hitbox, @player.hitbox).collided
        # TODO: Add score
        @money.delete(cash)
      end
    end
  end
end
