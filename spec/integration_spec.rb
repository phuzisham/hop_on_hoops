require('spec_helper')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('error: sign-in path', {:type => :feature}) do
  it('prevents a user from signing in if not signed up') do
    visit('/')
    click_link('Log In')
    fill_in('user_name_id', :with => 'John')
    fill_in('user_password_id', :with => 'password')
    click_button('Log_In_id')
    expect(page).to have_content('Username or password was incorrect.')
  end
end

describe('create game path', {:type => :feature}) do
  it('creates a court, then a game, and automatically adds user to their game') do
    visit('/')
    click_link('Log In')
    click_link('sign_up_here')

    fill_in('register_full_name', :with => 'John')
    fill_in('register_user_name', :with => 'John123')
    fill_in('register_user_pass', :with => 'johnpassword')
    click_button('Create Account')

    visit('/')
    click_link('Log In')
    fill_in('user_name_id', :with => 'John123')
    fill_in('user_password_id', :with => 'johnpassword')
    click_button('Log_In_id')

    click_link('Courts')
    # fill_in('capybara_court_title', :with => Kort)

    # expect(page).to have_content('Sign out')
    # expect(page).to have_content('Kort')
    # expect(page).to have_content('Gameroo')
  end
end

# describe('error: join-game path', {:type => :feature}) do
#   it('prevents a user from joining a game if not signed up') do
#     test_court = Court.create({:title => "CourtTest", :location => "LocationTest", :description => "DescriptionTest", :hoop_count => 1, :rating => 5})
#     test_game = Game.create({:game_name => 'Game', :time => "2017-10-13 17:00:00"})
#     test_game.courts.push(test_court)
#     visit('/')
#     binding.pry
#     click_link('Game')
#     click_button('Join_Game_id')
#     expect(page).to have_content('You must be signed in to join games.')
#   end
# end

# describe('error: create-game path', {:type => :feature}) do
#   it('prevents a user from creating a game if not signed up') do
#
#   end
# end

# describe('error: create-court path', {:type => :feature}) do
#   it('prevents a user from creating a court if not signed up') do
#
#   end
# end
