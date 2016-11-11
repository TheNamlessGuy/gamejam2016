require "gosu"

class MapHitBox
  def initialize (x, y, w, h)
    @box = [x, y, w, h]
    @type = :SOLID
  end

  def gethitbox
    return @box
  end

  def gettype
    return @type
  end
end

class MapGround
  def initialize (x1, x2, type)
    @ground = [x1, 500, x2 - x1, 600]
    @type = type
  end

  def gethitbox
    return @ground
  end

  def gettype
    return @type
  end
end

class Map
  def initialize
    @map = []
  end

  def loadmap (mapname)
    @map = []
    #TODO: Different types of maps
    @map.push(MapGround.new(0, 200, :WATER), MapGround.new(200, 800, :GROUND_SAND))
  end

  def collisioncheck (collisionbox)
    @map.each do |hitbox|
      if collisionbox[0]+collisionbox[2]>=hitbox[0] and collisionbox[0]<=hitbox[0]+hitbox[2] and collisionbox[1]+collisionbox[3]>=hitbox[1] and collisionbox[1]<=hitbox[1]+hitbox[3]
        return true
      end
    end
    return false
  end

  def drawhitbox (hitbox, camx, camy, type)
    color = Gosu::Color.new(0xffffffff)
    x1 = hitbox[0]-camx
    x2 = hitbox[0]+hitbox[2]-camx
    y1 = hitbox[1]-camy
    y2 = hitbox[1]+hitbox[3]-camy
    Gosu::draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color)
  end

  def draw (cx, cy)
    @map.each do |hbox|
      drawhitbox(hbox.gethitbox, cx, cy, hbox.gettype)
    end
  end
end
