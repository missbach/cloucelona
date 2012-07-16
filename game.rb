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
include Rubygame::Sprites

%w(core lib).each { |folder| Dir["#{folder}/*.rb"].each { |file| require_relative file } }
 
class Game
  
  @@instance = nil
  
  SCREEN_SIZE = [800, 600].context_tap do
    define_singleton_method(:width) { first }
    define_singleton_method(:height) { last }
  end
  
  def self.inst
    @@instance
  end
  
  def self.new
    raise "multiple game instances not allowed" if @@instance
    @@instance = super
  end
  
  include EventHandler::HasEventHandler
  
  def initialize
    @screen = Screen.new SCREEN_SIZE, 0, [HWSURFACE, DOUBLEBUF]
    @screen.title = "Cloucelona (&Paste)"
 
    @queue = EventQueue.new.context_tap do
      enable_new_style_events
      ignore = [MouseMoved]
    end
    
    @clock = Clock.new.context_tap do
      target_framerate = 60
      calibrate
      enable_tick_events
    end
    
    make_magic_hooks QuitRequested => :quit, KeyPressed => lambda { |obj, evt| quit if evt.key == :escape }
    
    setup_units
  end
  
  def setup_units
    @units = Group.new
    40.times { @units << Pedestrian.new }
    @units << Thief.new
    @units.each { |unit| make_magic_hooks_for unit, { YesTrigger.new() => :handle } if unit.requests_updates? }
  end
  
  def quit
    Rubygame.quit
    exit
  end
 
  def run
    loop { update; draw }
  end
 
  def update
    (@queue.context_tap { fetch_sdl_events } << @clock.tick).each { |event| handle event }
  end
 
  def draw
    @screen.fill :black
    @units.draw @screen
    @screen.flip
  end
  
  attr_reader :units
  
  self
end.new.run