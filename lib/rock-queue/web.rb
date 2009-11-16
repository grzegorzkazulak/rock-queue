require 'rubygems'
require 'sinatra/base'
require 'erb'

module RockQueue
  class Web < Sinatra::Base
    current_dir = File.dirname(File.expand_path(__FILE__))
    
    set :views,  "#{current_dir}/web/views"
    set :public, "#{current_dir}/web/public"
    set :static, true
    
    get "/" do
      redirect url(:dashbaord)
    end
    
    get "/dashboard" do
      show 'dashboard'
    end
    
  end
end
