require 'gosu'
require './main_menu.rb'
require './playstate.rb'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Capitalism Ruined My Vacation!"
    @lastFrameTime = 0
    
    @currentState = 0
    @states = [MainMenu.new(self), PlayState.new(self)]
  end

  def update
    ms = Gosu::milliseconds()
    delta = ms - @lastFrameTime
    @lastFrameTime = ms
    
    event = @states[@currentState].update(delta)
    if event == :play
      @currentState += 1
    elsif event == :quit
      close
    end
  end

  def draw
    @states[@currentState].draw
  end
end

window = GameWindow.new
window.show
