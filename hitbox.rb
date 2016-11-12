def collisioncheck(hbox1, hbox2)
  collisionbox = hbox1.get
  hitbox = hbox2.get
  collisionbox[0]+collisionbox[2]>=hitbox[0] and collisionbox[0]<=hitbox[0]+hitbox[2] and collisionbox[1]+collisionbox[3]>=hitbox[1] and collisionbox[1]<=hitbox[1]+hitbox[3]
  #if collisionbox[0]+collisionbox[2]>=hitbox[0] and collisionbox[0]<=hitbox[0]+hitbox[2] and collisionbox[1]+collisionbox[3]>=hitbox[1] and collisionbox[1]<=hitbox[1]+hitbox[3]
  #  return true
  #end
  #return false
end

class HitBox
  def initialize(x, y, w, h)
    @box = [x, y, w, h]
  end

  def get
    return @box
  end

  def collideswith(other)
    return collisioncheck(self, other)
  end
end
