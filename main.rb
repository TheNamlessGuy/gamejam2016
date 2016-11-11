require 'gosu'
require './player.rb'
require './map.rb'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = ""
    @lastFrameTime = 0
    
    @player = Player.new(100, 400)
    @bullets = []
    @map = Map.new
    @map.loadmap("de_dust2")
  end

  def update
    ms = Gosu::milliseconds()
    delta = ms - @lastFrameTime
    @lastFrameTime = ms
    
    @player.update(@bullets, delta)
  end

  def draw
    # Draw map, then player, then hud
    @map.draw(0, 0)
    @player.draw
  end
end

window = GameWindow.new
window.show
