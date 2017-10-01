require('spec_helper')

describe(Court) do
  it { should have_many(:players) }
end
