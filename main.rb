# -*- coding: utf-8 -*-
require 'gosu'
require './main_menu.rb'
require './playstate.rb'
require './cutscene.rb'
require './scene.rb'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Capitalism Ruined My Vacation!"
    @lastFrameTime = 0
    
    @currentState = 0
    #hehehe
    font = Gosu::Font.new self, "./ARCADECLASSIC.TTF", 50
    cutscene1 = Cutscene.new([Scene.new(Gosu::Image.new("res/cutscene_intro_1.png"), font, ["", "", ""]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_2.png"), font, ["cutscene", "intro", "2"]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_3.png"), font, ["cutscene", "intro", "3"]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_4.png"), font, ["cutscene", "intro", "4"]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_5.png"), font, ["cutscene", "intro", "5"]),
                              Scene.new(nil, font, ["cutscene", "intro", "6"])])
    #hehehe

    @states = [MainMenu.new(self), cutscene1, PlayState.new(self)]
  end

  def update
    ms = Gosu::milliseconds()
    delta = ms - @lastFrameTime
    @lastFrameTime = ms
    
    case @states[@currentState].update(delta)
    when :play
      @currentState += 1
    when :quit
      close
    when :cutscene_end
      @currentState = 2
    end
  end

  def draw
    @states[@currentState].draw
  end
end

window = GameWindow.new
window.show
