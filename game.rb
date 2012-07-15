#!/usr/bin/env ruby
 
require 'rubygems'
require 'rubygame'
 
class Game
  def initialize
    @screen = Rubygame::Screen.new [800,600], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @screen.title = "Cloucelona (&Paste)"
 
    @queue = Rubygame::EventQueue.new
    @clock = Rubygame::Clock.new
    @clock.target_framerate = 60
  end
 
  def run
    loop do
      update
      draw
      @clock.tick
    end
  end
 
  def update
    @queue.each do |ev|
      case ev
        when Rubygame::QuitEvent
          Rubygame.quit
          exit
      end
    end
  end
 
  def draw
    @screen.flip
  end
end
 
game = Game.new
game.run