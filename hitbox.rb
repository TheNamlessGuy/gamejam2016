class CollisionInfo
  attr_reader :collided, :direction, :x, :y

  def initialize(col, dir, x, y)
    @collided = col
    @direction = dir
    @x = x
    @y = y
  end

end

def hitboxcollisioncheck(hbox1, hbox2)
  b1 = hbox1.get
  b2 = hbox2.get
  if b1[0]+b1[2]>=b2[0] and b1[0]<=b2[0]+b2[2] and b1[1]+b1[3]>=b2[1] and b1[1]<=b2[1]+b2[3]
    right = (b1[0]+b1[2]-b2[0]).abs
    left = (b1[0]-(b2[0]+b2[2])).abs
    down = (b1[1]+b1[3]-b2[1]).abs
    up = (b1[1]-(b2[1]+b2[3])).abs
    if right <= left and right <= down and right <= up
      return CollisionInfo.new(true, :e, b2[0], 0)
    elsif left <= right and left <= down and left <= up 
      return CollisionInfo.new(true, :w, b2[0]+b2[2], 0)
    elsif up <= left and up <= right and up <= down
      return CollisionInfo.new(true, :n, 0, b2[1]+b2[3])
    elsif down <= left and down <= right and down <= up
      return CollisionInfo.new(true, :s, 0, b2[1])
    end
  end
  return CollisionInfo.new(false, nil, 0, 0)
end

class HitBox
  def initialize(x, y, w, h)
    @box = [x, y, w, h]
  end

  def get
    return @box
  end

  def set(index, value)
    @box[index] = value
  end

  def collideswith(other)
    return hitboxcollisioncheck(self, other)
  end
end
