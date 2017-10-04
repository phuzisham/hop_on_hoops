require('spec_helper')

describe(Court) do
  it { should belong_to(:player) }
  it { should belong_to(:game) }
end
