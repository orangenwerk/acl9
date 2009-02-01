require 'rubygems'
require 'activesupport'
require 'spec'
require 'activerecord'
require 'action_controller'

require 'action_controller/test_process'
require 'action_controller/integration'

require 'active_record/fixtures'

require 'rails/version'

require 'spec/rails/matchers'
require 'spec/rails/mocks'

class ApplicationController < ActionController::Base
end

require 'spec/rails/example'

begin
  require 'spec/rails/extensions'
rescue MissingSourceFile
  # it tries to load application.rb 
end

#require 'spec/rails/interop/testcase'

this_dir = File.dirname(__FILE__)

RAILS_ROOT = File.join(this_dir,  "..")

ActiveRecord::Base.logger = Logger.new(this_dir + "/debug.log")

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "#{this_dir}/db/test.sqlite3")

load(File.join(this_dir, "db", "schema.rb"))

ActionController::Routing::Routes.draw do |map|
  map.connect ":controller/:action/:id"
end

module Rails
  mattr_accessor :logger
end

Rails.logger = ActiveRecord::Base.logger
