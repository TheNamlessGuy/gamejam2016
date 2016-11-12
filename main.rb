require 'gosu'
require './playstate.rb'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = ""
    @lastFrameTime = 0
    
    @currentState = 0
    @states = [PlayState.new]
  end

  def update
    ms = Gosu::milliseconds()
    delta = ms - @lastFrameTime
    @lastFrameTime = ms
    
    @states[@currentState].update(delta)
  end

  def draw
    @states[@currentState].draw
  end
end

window = GameWindow.new
window.show
