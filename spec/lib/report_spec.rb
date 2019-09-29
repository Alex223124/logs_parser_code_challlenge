require "spec_helper"

RSpec.describe "Report" do

  let(:arguments) { [ ["webpages_with_most_page_views", "webpages_with_most_unique_page_views"],
                      [Page.new("/help_page/1", 80, ["126.318.035.038", "126.318.035.038",
                                                                          "929.398.951.889", "802.683.925.780"]),
                       Page.new("/contact", 35, ["444.701.448.104", "802.683.925.780",
                                                                      "336.284.013.698", "715.156.286.412"]),
                       Page.new("/help_page/2", 80, ["336.284.013.698", "715.156.286.412",
                                                                          "555.576.836.194", "061.945.150.735"])]
                  ] }

  before(:each) do
    @report = Report.new(*arguments)
  end

  describe '#initialize' do

    it 'should initialize correct instance' do
      expect(@report.instance_variable_get(:@types)).to eq(["webpages_with_most_page_views", "webpages_with_most_unique_page_views"])
      expect(@report.instance_variable_get(:@amount_of_records)).to eq(nil)
      expect(@report.instance_variable_get(:@pages)).to eq(arguments[1])
      expect(@report.result).to eq([])
    end
  end

  describe '#title' do

    let(:type) { "webpages_with_most_page_views" }

    it 'should return formatted title' do
      expected_result = "webpages_with_most_page_views:\n"
      expect(@report.send(:title, type)).to eq(expected_result)
    end
  end

  describe '#record' do

    let(:type) { "webpages_with_most_page_views" }
    let(:page) { Page.new("/contact", 35, ["444.701.448.104", "802.683.925.780",
                                                                "336.284.013.698", "715.156.286.412"]) }

    it 'should return formatted record' do
      expected_result = "Url: /contact, visits: 35 \n"
      expect(@report.send(:record, page, type)).to eq(expected_result)
    end
  end

  describe '#paragraph' do

    context 'when we have webpages_with_most_page_views type' do

      let(:type) { "webpages_with_most_page_views" }

      it 'should return paragraph with webpages with most page views ordered by page views' do
        expected_result = "Url: /help_page/2, visits: 80 " +
                          "\nUrl: /help_page/1, visits: 80 " +
                          "\nUrl: /contact, visits: 35 \n"
        expect(@report.send(:paragraph, type)).to eq(expected_result)
      end
    end

    context 'when we have webpages_with_most_unique_page_views type' do

      let(:type) { "webpages_with_most_unique_page_views" }

      it 'should return paragraph with webpages with most uniq page views ordered by page views' do
        expected_result = "Url: /help_page/2, uniq visits: 4 " +
                          "\nUrl: /contact, uniq visits: 4 " +
                          "\nUrl: /help_page/1, uniq visits: 3 \n"
        expect(@report.send(:paragraph, type)).to eq(expected_result)
      end
    end
  end

  describe '#body' do

    let(:type) { "webpages_with_most_page_views" }

    it 'should return correct title + paragraph ' do
      expected_result = "webpages_with_most_page_views:" +
                        "\nUrl: /help_page/2, visits: 80 " +
                        "\nUrl: /help_page/1, visits: 80 " +
                        "\nUrl: /contact, visits: 35 \n"
      expect(@report.send(:body, type)).to eq(expected_result)
    end
  end

  describe '#run' do

    it 'should set full report to @result instance varialbe' do
      expected_result = ["webpages_with_most_page_views:" +
                         "\nUrl: /help_page/2, visits: 80 " +
                         "\nUrl: /help_page/1, visits: 80 " +
                         "\nUrl: /contact, visits: 35 \n",
                         "webpages_with_most_unique_page_views:" +
                         "\nUrl: /help_page/2, uniq visits: 4 " +
                         "\nUrl: /contact, uniq visits: 4 " +
                         "\nUrl: /help_page/1, uniq visits: 3 \n"]
      @report.run
      expect(@report.result).to eq(expected_result)
    end
  end

  describe '#amount_of_records' do

    context 'when we dont specify number_of_records as argument' do

      it 'should return value specified in constant' do
        expected_result = 10
        expect(@report.send(:amount_of_records)).to eq(expected_result)
      end
    end

    context 'when we specify number_of_records as argument' do

      let(:arguments) { [ ["webpages_with_most_page_views", "webpages_with_most_unique_page_views"],
                          [Page.new("/help_page/1", 80, ["126.318.035.038", "126.318.035.038",
                                                         "929.398.951.889", "802.683.925.780"])],
                          5
                      ] }

      it 'should return value specified in constant' do
        expected_result = arguments[2]
        expect(@report.send(:amount_of_records)).to eq(expected_result)
      end
    end
  end
end