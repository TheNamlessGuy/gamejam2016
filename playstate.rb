require './player.rb'
require './map.rb'

class PlayState
  def initialize
    @player = Player.new(100, 400)
    @bullets = []
    @map = Map.new
    @map.loadmap("de_dust2.rb")
  end

  def update(delta)
    @player.update(@bullets, delta)
  end

  def draw
    @map.draw(0, 0)
    @player.draw
  end
end
