require File.dirname(__FILE__) + '/spec_helper'

require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

class Post < ActiveRecord::Base
  include RockQueue::ActiveRecordHelper

  def archive
  end
end

class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
    end
  end
end

CreatePosts.migrate(:up)

RockQueue::Config.settings do |config|
  config.adapter = :resque
  config.host = 'localhost'
  config.port = '6379'
end

describe "Object with ActiveRecordHelper" do
  before(:each) do
    @post = Post.create(:title => "Test")
  end

  it "class responds to .perform" do
    @post.class.perform([@post.id, :title]).should == "Test"
  end

  it "calls a method asynchronously" do
    @post.async(:archive)
    rq = @post.instance_variable_get(:@rq)
    rq.pop.should == [Post, [[@post.id, "archive"]]]
  end
end
