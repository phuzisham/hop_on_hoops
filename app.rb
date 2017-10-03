require("bundler/setup")
Bundler.require(:default)
enable :sessions

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

helpers do
  def current_user
    if session[:user_id]
      Player.find { |u| u.id == session[:user_id] }
    else
      nil
    end
  end
end

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

post('/login') do
  user = Player.find { |u| u.user_name == params["user_name"] }
  if user && user.auth_pass(params["user_password"], user.user_password)
    session.clear
    session[:user_id] = user.id
    redirect("/")
  else
    @error = 'Username or password was incorrect'
    erb :error
  end
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
  Game.create(court_id: court, time: time, date: date, game_name: game_name)
  redirect('/')
end
