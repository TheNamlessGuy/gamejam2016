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
