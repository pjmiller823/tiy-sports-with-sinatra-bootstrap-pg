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
require_relative 'game'

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  @number_of_links = Team.all.size / 5

  page = (params["page"] || 1).to_i
  page_offset = (page - 1) * 5
  @teams = Team.all.limit(5).offset(page_offset)
  @games = Game.all

  erb :home
end
