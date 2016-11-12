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
    cutscene1 = Cutscene.new([Scene.new(Gosu::Image.new("res/cutscene_intro_1.png"), font, ["dukke   is   on   airplane", "to   bahamas"]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_2.png"), font, ["dukke   is   sunbathing   on   ", "beach", "of   bahamas"]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_3.png"), font, ["wallet   start   to   rattle", "", "fiercely"]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_4.png"), font, ["suddenly   wallet   explodes", "and   money   spreads", "out"]),
                              Scene.new(Gosu::Image.new("res/cutscene_intro_5.png"), font, ["a   money   punches   dukke", "hits   hard   and   dukke", "faints"]),
                              Scene.new(nil, font, ["revenge", "much    time     now", "", "yes"])])
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
