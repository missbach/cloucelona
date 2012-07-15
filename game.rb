#!/usr/bin/env ruby
 
require 'rubygems'
require 'active_support'
require 'active_support/all'
require 'rubygame'
require_relative 'extensions.rb'

include Rubygame
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

Dir["lib/*.rb"].each { |file| require_relative file }
 
class Game
  
  include EventHandler::HasEventHandler
  
  def initialize
    @screen = Screen.new [800,600], 0, [HWSURFACE, DOUBLEBUF]
    @screen.title = "Cloucelona (&Paste)"
 
    @queue = EventQueue.new.context_tap do
      #enable_new_style_events
      ignore = [MouseMoved]
    end
    
    @clock = Clock.new.context_tap do
      target_framerate = 60
      calibrate
      enable_tick_events
    end
    
    make_magic_hooks(QuitEvent => :quit)
  end
  
  def quit
    Rubygame.quit
    exit
  end
 
  def run
    loop { update; draw }
  end
 
  def update
    @queue.fetch_sdl_events
    (@queue << @clock.tick).each { |event| handle event }
  end
 
  def draw
    @screen.flip
  end
  
  self
end.new.run