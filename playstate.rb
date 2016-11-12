require './player.rb'
require './map.rb'
require './enemies/moneygolem.rb'
require './enemies/billbird.rb'
require './hitbox.rb'
require './inventory.rb'
require './particle.rb'

# TODO: Fucking remove this what are you doing stop
require './gosu_facade.rb'

class PlayState
  def initialize(window)
    @player = Player.new(368, 400)
    @bullets = []
    @map = Map.new
    @map.loadmap("de_dust2.rb")

    @chair = Gosu::Image.new "res/chair.png"

    @enemies = []
    #@enemies = @map.getobjectlist
    @enemies.push(MoneyGolem.new(500, 435, :e, 200))
    @enemies.push(BillBird.new(500, 300, :e, 50))
    
    @money = []

    @particles = []

    @inv = Inventory.new(window)
  end

  def update(delta)
    shoot = @player.update(delta)
    if @player.dead
      puts "u ded sonny"
      @player.hitbox.get[0] = 100
      @player.hitbox.get[1] = 400
      @player.dead = false
    end
    if shoot
      if @inv.bulletcount > 0
        @bullets.push(Bullet.new(@player.hitbox.get[0] + 32, @player.hitbox.get[1] + 32, @player.aimdir))
        @inv.bulletcount -= 1
      end
    end
    
    @bullets.each do |bullet|
      bullet.update(delta)
    end
    
    @enemies.each do |enemy|
      enemy.update(delta)
    end
    
    @money.each do |moni|
      moni.update(delta)
    end

    @particles.each do |p|
      p.update(delta)
      if p.dead?
        @particles.delete(p)
      end
    end
    
    handlecollisions
  end

  def draw
    @map.draw(@player.hitbox.get[0] - 368, 0)

    @chair.draw(-@player.hitbox.get[0], 333, 1, 0.6, 0.6)

    @bullets.each do |bullet|
      bullet.draw(@player.hitbox.get[0] - 368)
    end

    @enemies.each do |enemy|
      enemy.draw(@player.hitbox.get[0] - 368)
    end

    @money.each do |cash|
      cash.draw(@player.hitbox.get[0] - 368)
    end
    
    @particles.each do |p|
      p.draw(@player.hitbox.get[0] - 368)
    end

    @player.draw

    @inv.draw
  end

  #PRIVATE (SORTA)
  
  def handlecollisions
    info = @map.collisioncheck(@player.hitbox)
    if info.length > 0
      info.each do |i|
        case i.direction
        when :e
          @player.hitbox.set(0, i.x - @player.hitbox.get[2])
          @player.xSpeed = 0
        when :w
          @player.hitbox.set(0, i.x)
          @player.xSpeed = 0
        when :n
          @player.hitbox.set(1, i.y)
          @player.yVel = 0
        when :s
          @player.hitbox.set(1, i.y - @player.hitbox.get[3])
          @player.yVel = 0
          @player.jumping = false
        end
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
          (0..10).each do |i|
            @particles.push(Particle.new(enemy.hitbox.get[0]+32, enemy.hitbox.get[1]+32, 16, 16, "res/particle_coin"))
          end
        end
      end
      
      if hitboxcollisioncheck(enemy.hitbox, @player.hitbox).collided
        @player.dead = true
      end
    end
   
    # Bullet hit ground or off screen

    @bullets.each do |bullet|
      info = @map.collisioncheck(bullet.hitbox)
      info.each do |i|
        if i.collided
          @bullets.delete(bullet)
        elsif bullet.hitbox.get[1] <= 0 or bullet.hitbox.get[1] >= 600 or
            bullet.hitbox.get[0] >= 800 + @player.hitbox.get[0] - 368 or
            bullet.hitbox.get[0] <= 0 + @player.hitbox.get[0] - 368
          @bullets.delete(bullet)
        end
      end
    end

    # Player picking up money
    @money.each do |cash|
      if hitboxcollisioncheck(cash.hitbox, @player.hitbox).collided
        @inv.money += cash.value
        @money.delete(cash)
      end
    end
  end
end
