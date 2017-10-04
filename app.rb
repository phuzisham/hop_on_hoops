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

# ///login and logout///
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

get('/signout') do
  session.clear
  erb(:index)
end
# //////

# ///view and update games///
get '/game/:id' do
  @game = Game.find(params[:id])
  @players = Player.all()
  erb(:game)
end

post('/create_game') do
  court = Court.find(params['court'])
  time = params['time']
  date = params['date']
  datetime = date + " " + time
  game_name = params['game_name']
  game = Game.create(time: datetime, game_name: game_name)
  game.courts.push(court)
  current_user.games.push(game)
  redirect('/')
end

get('/join_game/:id') do
  game = Game.find(params['id'])
  id = game.id
  check = nil;

  game.players.each do |player|
    if player.id == current_user.id
      check = false
    else
      check = true
    end
  end
  if current_user
    if check
      current_user.games.push(game)
      redirect("game/#{id}")
    else
      @error = 'You\'ve already joined this game!'
      erb(:error)
    end
  else
    @error = 'You must be signed in to join games'
    erb(:error)
  end
end
# //////

# ///create courts///
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
# //////

# ///view and update a court///
get '/courts/:id' do
  @court = Court.find(params[:id])
  # binding.pry
  erb(:court_page)
end

patch '/courts/:id/update' do
  title = params['title']
  location = params['location']
  description = params['description']
  hoop_count = params['hoop_count']
  rating = params['rating']
  @court = Court.find(params[:id])
  Court.update({title: title})
  Court.update({location: location})
  Court.update({description: description})
  Court.update({hoop_count: hoop_count})
  Court.update({rating: rating})
redirect "/courts/#{@court.id}"
end

# //////
