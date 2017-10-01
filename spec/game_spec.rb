require('spec_helper')

describe(Game) do
  it { should belong_to(:player) }
  it { should belong_to(:court) }
end
