require('spec_helper')

describe(Player) do
  it { should have_many(:games) }

  it("ensures the length of title is at most 100 characters") do
    player = Player.new({name: "a".*(101)})
    expect(player.save).to(eq(false))
  end

  it("ensures that name doesn't already exist") do
    Player.create({name: 'Larry Bird'})
    player = Player.new({name: 'Larry Bird'})
    expect(player.save).to(eq(false))
  end

  it('will capitalize name') do
    player = Player.new({name: 'larry bird', user_name: 'LarryB1rd', user_password: '1234'})
    player.save()
    expect(player.name).to(eq('Larry Bird'))
  end

  it('will test that name isn\'t an empty string') do
    player = Player.new({name: ''})
    expect(player.save).to(eq(false))
  end

  it('will allow a user to create a secure password') do
    player = Player.new({:name => 'Terrence', :user_name => 'LarryB1rd', :user_password => 'imTheBest'})
    player.save
    test_hash = BCrypt::Password.new(player.user_password)
    expect(player.user_password).to(eq(test_hash))
  end
end
