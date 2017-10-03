require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/') do
  @games = Game.all
  @courts = Court.all
  erb(:index)
end


get('/sign_up') do
  erb(:register)
end

get('/register') do
  name = params['name']
  user_name = params['user_name']
  user_password = params['user_password']
  Player.create({name: name, user_name: user_name, user_password: user_password})
  redirect('/')
end

get('/login') do
  @games = Game.all
  @courts = Court.all
  @user = Player.where(:user_name => params["user_name"]).first
  erb(:register)
end

get '/game/:id' do
  @game = Game.find(params[:id])
  @court = Court.find(params[:id])
  erb(:game)
end

get '/courts' do
  @courts = Court.all()
  erb(:courts)
end

post '/courts' do
  location = params['location']
  title = params['title']
  hoop_count = params['hoop_count']
  rating = params['rating']
  description = params['description']
  @court = Court.create({location: location, hoop_count: hoop_count, rating: rating, description: description, title: title})
  redirect(:courts)
end

post('/create_game') do
  court = params['court']
  time = params['time']
  date = params['date']
  game_name = params['game_name']
  binding.pry
  Game.create(court_id: court, time: time, date: date, game_name: game_name)
  redirect('/')
end
