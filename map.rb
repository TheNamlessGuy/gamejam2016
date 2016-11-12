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
    @bg = Gosu::Image.new("res/back_beach.png")
    @fg = Gosu::Image.new("res/front_beach.png")
    @width = 0
  end

  def loadmap (mapname)
    @map = []
    @objects = []
    #TODO: Different types of maps
    mapfile = File.read("maps/" + mapname)
    eval mapfile
    @map.push(MapGround.new(0, @width, :GROUND))
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

  def set_width (w)
    @width = w
  end
  # ----------------------------------

  def collisioncheck (collisionbox)
    collisionlist = []
    @map.each do |hitbox|
      info = hitboxcollisioncheck(collisionbox, hitbox.get)
      if info.collided
        collisionlist.push(info)
      end
    end
    if collisionbox.get[0] <= 0
      collisionlist.push(CollisionInfo.new(true, :w, 0, 0))
    elsif collisionbox.get[0]+collisionbox.get[2] >= @width
      collisionlist.push(CollisionInfo.new(true, :e, @width, 0))
    end
    return collisionlist
  end

  def getobjectlist 
    return @objects
  end

  def draw (cx, cy)
    draw_bg(cx, cy)
    draw_fg(cx, cy)
    @map.each do |hbox|
      hbox.draw(cx, cy) unless hbox.gettype == :GROUND
    end
  end

  def draw_fg(cx, cy)
    cx = cx % 1200
    @fg.draw(1199-cx, 0, 0)
    @fg.draw(-cx, 0, 0)
  end

  def draw_bg(cx, cy)
    # TODO: Scroll
    @bg.draw(((cx + 368).to_f / @width.to_f) * -50.0, 0, 0)
  end
end
