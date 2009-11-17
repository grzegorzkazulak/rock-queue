require 'rubygems'
require 'sinatra/base'
require 'erb'

module RockQueue
  class Web < Sinatra::Base
    
    configure do
      current_dir = File.dirname(File.expand_path(__FILE__))
      set :views,  "#{current_dir}/web/views"
      set :public, "#{current_dir}/web/public"
      set :static, true
      set :raise_errors, true
    end
    
    get '/' do
      redirect '/dashboard'
    end
    
    get '/dashboard' do
      erb :dashboard
    end
    
  end
end
