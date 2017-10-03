require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/') do
  @courts = Court.all
  erb(:index)
end

get('/home/:id') do
  @user = Player.find(params['id'])
  if @user != nil
    @courts = Court.all
    @games = Game.all
    erb(:home)
  else
    erb(:index)
  end
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
  if @user != nil
    @user_name = params["user_name"]
    password_hash = BCrypt::Password.new(@user.user_password)
    if password_hash == params["user_password"]
      redirect("/home/#{@user.id}")
    else
      erb(:login_error)
    end
  else
    erb(:register)
  end
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
  Game.create(court_id: court, time: time)
  redirect(:index)
end
