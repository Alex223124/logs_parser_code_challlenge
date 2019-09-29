require "spec_helper"

RSpec.describe "Visit" do

  let(:arguments) { ["/home", "184.123.665.067"] }

  before do
    @visit = Visit.new(*arguments)
  end

  describe '#initialize' do

    it 'should initialize correct instance' do
      expect(@visit.url).to eq("/home")
      expect(@visit.ip).to eq("184.123.665.067")
    end
  end
end