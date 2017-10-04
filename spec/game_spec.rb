require('spec_helper')

describe(Game) do
  it { should have_many(:players) }

  it("ensures the length of title is at most 100 characters") do
    game = Game.new({game_name: "a".*(101)})
    expect(game.save).to(eq(false))
  end

  it("ensures that title doesn't already exist") do
    Game.create({game_name: 'Oaks Park'})
    game = Game.new({game_name: 'Oaks Park'})
    expect(game.save).to(eq(false))
  end

  it('will capitalize the game name') do
    game = Game.create({game_name: 'oaks park'})
    expect(game.game_name).to(eq('Oaks Park'))
  end

  it('will test that game_name isn\'t an empty string') do
    game = Game.new({game_name: ''})
    expect(game.save).to(eq(false))
  end
end
