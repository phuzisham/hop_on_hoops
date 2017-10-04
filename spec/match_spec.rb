require('spec_helper')

describe(Match) do
  it { should belong_to(:player) }
  it { should belong_to(:court) }
  it { should belong_to(:game) }
end
