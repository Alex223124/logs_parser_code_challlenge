require "spec_helper"

RSpec.describe "Statistics" do

  let(:pages) {
                [Page.new("/help_page/1", 80, ["126.318.035.038", "126.318.035.038",
                                               "929.398.951.889", "802.683.925.780"]),
                 Page.new("/contact", 35, ["444.701.448.104", "802.683.925.780",
                                           "336.284.013.698", "715.156.286.412"]),
                 Page.new("/help_page/1", 80, ["336.284.013.698", "715.156.286.412",
                                               "555.576.836.194", "061.945.150.735"])]
              }

  before do
    @instance = Statistics.new(pages)
  end

  describe '#initialize' do

    it 'should initialize correct instance' do
      expect(@instance.instance_variable_get(:@pages)).to eq(pages)
    end
  end
end
