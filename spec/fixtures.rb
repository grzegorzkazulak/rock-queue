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

ActiveRecord::Schema.define(:version => 1) do
  create_table :posts do |t|
    t.string :title
  end
end

class TestJob
  def self.perform
  end
end
