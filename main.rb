require 'gosu'
require './player.rb'

class GameWindow < Gosu::Window
  p = Player.new

  def initialize
    super 640, 480
    self.caption = "TEST"
  end

  def update
  end

  def draw
  end
end

window = GameWindow.new
window.show
