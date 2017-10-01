require('spec_helper')

describe(Court) do
  it { should have_many(:players) }

  it("ensures the length of title is at most 100 characters") do
    court = Court.new({title: "a".*(101)})
    expect(court.save).to(eq(false))
  end

  it("ensures that title doesn't already exist") do
    Court.create({title: 'Oaks Park'})
    court = Court.new({title: 'Oaks Park'})
    expect(court.save).to(eq(false))
  end

  it('will capitalize title') do
    court = Court.create({title: 'oaks park'})
    expect(court.title).to(eq('Oaks Park'))
  end

  it('will test that title isn\'t an empty string') do
    court = Court.new({title: ''})
    expect(court.save).to(eq(false))
  end
end
