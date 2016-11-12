require "gosu"

require "./hitbox.rb"
require "./map_helpers_objectcreators.rb"

def local_drawhitbox (hitbox, camx, camy, hexcolor)
  hbox = hitbox.get
  x1 = hbox[0]-camx
  x2 = hbox[0]+hbox[2]-camx
  y1 = hbox[1]-camy
  y2 = hbox[1]+hbox[3]-camy
  gosu_draw_rect(x1, y1, x2, y2, hexcolor, 0)
end

class MapHitBox
  def initialize (x, y, w, h, type)
    @box = HitBox.new(x, y, w, h)
    @type = type
  end

  def get
    return @box
  end

  def gethitbox
    return @box.get
  end

  def gettype
    return @type
  end

  def draw (camx, camy)
    local_drawhitbox(@box, camx, camy, 0xffffffff)
  end
end

class MapGround
  def initialize (x1, x2, type)
    @ground = HitBox.new(x1, 500, x2 - x1, 600)
    @type = type
  end

  def get
    return @ground
  end

  def gethitbox
    return @ground.get
  end

  def gettype
    return @type
  end

  def draw (camx, camy)
    color = 0xffffffff
    case @type
    when :GROUND_SAND
      color = 0xffffff00
    when :WATER
      color = 0xff0000ff
    else
      color = 0xffffffff
    end
    local_drawhitbox(@ground, camx, camy, color)
  end
end
