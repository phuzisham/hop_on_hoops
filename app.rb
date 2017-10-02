require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/') do
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
  @user = Player.where(:user_name => params["user_name"]).first
  if @user != nil
    @user_name = params["user_name"]
    password_hash = BCrypt::Password.new(@user.user_password)
    if password_hash == params["user_password"]
      erb(:index)
    else
      erb(:login_error)
    end
  else
    erb(:register)
  end
end

# /////Courts////////
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
# ///////////
