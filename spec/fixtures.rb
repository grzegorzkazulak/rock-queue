require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

class Post < ActiveRecord::Base
  include RockQueue::ActiveRecordHelper

  def archive
    @archived = true
  end

  def archived?
    @archived == true
  end
end

ActiveRecord::Schema.define(:version => 1) do
  create_table :posts do |t|
    t.string :title
  end
end

Post.create!(:title => "Post 1")
Post.create!(:title => "Post 2")
Post.create!(:title => "Post 3")
Post.create!(:title => "Post 4")

class TestJob
  def self.perform
  end
end

class BadJob
  def self.perform
    fail
  end
end
