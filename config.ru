#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')
require 'rock-queue/web'
 
run RockQueue::Web.new