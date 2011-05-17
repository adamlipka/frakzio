require "rspec"
require 'sqlite3'
require 'active_record'

SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)
require "frakzio"
require "frakzio_validator"

ActiveRecord::Base.send :include, Frakzio

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "spec.db"
)

class Item < ActiveRecord::Base
  act_as_frakzio :width
end

if Item.table_exists?
  ActiveRecord::Base.connection.drop_table(:items)
end

if !Item.table_exists?
  ActiveRecord::Base.connection.create_table(:items) do |i|
    i.column :id, :integer
    i.column :width, :string
    i.column :created_at, :datetime
    i.column :updated_at, :datetime
  end
end