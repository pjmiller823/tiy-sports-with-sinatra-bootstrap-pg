require 'sinatra'
require 'pg'
require 'active_record'


ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "tiy-sports"
)
require_relative 'player'
require_relative 'team'
require_relative 'membership'

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  @teams = Team.all
  @player = Player.all
  erb :home
end
