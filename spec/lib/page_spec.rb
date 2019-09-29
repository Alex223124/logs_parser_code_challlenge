require "spec_helper"

RSpec.describe "Page" do

  let(:arguments) { ["/help_page/1", 80, ["126.318.035.038", "126.318.035.038", "929.398.951.889", "802.683.925.780"]] }

  before do
    @page = Page.new(*arguments)
  end

  describe '#initialize' do

    it 'should initialize correct instance' do
      expect(@page.url).to eq("/help_page/1")
      expect(@page.views).to eq(80)
      expect(@page.ip_addresses).to eq(["126.318.035.038", "929.398.951.889", "802.683.925.780"])
      expect(@page.uniq_views).to eq(3)
    end
  end
end