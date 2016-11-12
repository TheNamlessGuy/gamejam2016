require "gosu"

require "./map_helpers.rb"
require "./hitbox.rb"

class Map

  #PUBLIC FUNCTIONS
  #bool loadmap(mapname)
  #collisiontype collisioncheck(collisionbox)
  #void draw(camx, camy)

  def initialize
    @map = []
  end

  def loadmap (mapname)
    @map = []
    #TODO: Different types of maps
    #@map.push(MapGround.new(0, 200, :WATER), MapGround.new(200, 800, :GROUND_SAND))
    mapfile = File.read("maps/" + mapname)
    eval mapfile
  end

  # MAP LOADING DSL
  # ----------------------------------
  def create_mapbox (x, y, w, h, type)
    @map.push(MapHitBox.new(x, y, w, h, type))
  end

  def create_ground (x1, x2, type)
    @map.push(MapGround.new(x1, x2, type))
  end

  def set_theme (theme)
    #INGENTING
  end
  # ----------------------------------

  def collisioncheck (collisionbox)
    @map.each do |hitbox|
      if collisioncheck(collisionbox, hitbox)#collisionbox[0]+collisionbox[2]>=hitbox[0] and collisionbox[0]<=hitbox[0]+hitbox[2] and collisionbox[1]+collisionbox[3]>=hitbox[1] and collisionbox[1]<=hitbox[1]+hitbox[3]
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
    Gosu::draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color, 0)
  end

  def draw (cx, cy)
    @map.each do |hbox|
      drawhitbox(hbox.gethitbox, cx, cy, hbox.gettype)
    end
  end
end
