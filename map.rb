require "gosu"

require "./map_helpers.rb"
require "./hitbox.rb"
require "./gosu_facade.rb"

class Map

  #PUBLIC FUNCTIONS
  #bool loadmap(mapname)
  #collisiontype collisioncheck(collisionbox)
  #void update(deltatime)
  #void draw(camx, camy)

  def initialize
    @map = []
    @objects = []
  end

  def loadmap (mapname)
    @map = []
    @objects = []
    #TODO: Different types of maps
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

  def create_object (x, y, type)
    obj = objectcreator(x, y, type)
    @objects.push(obj) unless obj == nil
  end
  # ----------------------------------

  def collisioncheck (collisionbox)
    @map.each do |hitbox|
      info = hitboxcollisioncheck(collisionbox, hitbox.get)
      if info.collided
        return info
      end
    end
    return nil
  end

  def getobjectlist 
    return @objects
  end

  def draw (cx, cy)
    @map.each do |hbox|
      hbox.draw(cx, cy)
    end
  end
end
