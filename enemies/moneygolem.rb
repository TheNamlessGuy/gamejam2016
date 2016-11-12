require '../hitbox.rb'

class MoneyGolem
  attr_accessor :hitbox

  def initialize(x, y)
    @hitbox = HitBox.new(x, y, 25, 25)
  end

  def update(delta)

  end
  
  def draw

  end
end
