require "gosu"

require "./hitbox.rb"

class MapHitBox
  def initialize (x, y, w, h, type)
    @box = HitBox.new(x, y, w, h)
    @type = type
  end

  def gethitbox
    return @box.get
  end

  def gettype
    return @type
  end
end

class MapGround
  def initialize (x1, x2, type)
    @ground = HitBox.new(x1, 500, x2 - x1, 600)
    @type = type
  end

  def gethitbox
    return @ground.get
  end

  def gettype
    return @type
  end
end
