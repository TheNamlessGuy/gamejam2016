require 'gosu'
require './player.rb'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = ""
    
    @player = Player.new(100, 100)
  end

  def update
    @player.update
  end

  def draw
    # Draw map, then player, then hud
    @player.draw
  end
end

window = GameWindow.new
window.show
