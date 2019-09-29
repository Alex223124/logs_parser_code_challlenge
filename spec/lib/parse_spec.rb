require "spec_helper"

RSpec.describe "Parse" do

  let(:path) { File.absolute_path("spec/data/webserver.log") }

  before(:each) do
    @instance = Parse.new(path)
  end

  describe '#initialize' do

    it 'should initialize correct instance' do
      expect(@instance.instance_variable_get(:@path)).to eq(path)
      expect(@instance.instance_variable_get(:@records)).to eq([])
      expect(@instance.instance_variable_get(:@visits)).to eq([])
      expect(@instance.pages).to eq([])
    end
  end

  describe '#record' do

    let(:log_record) { "/help_page/1 126.318.035.038\n" }

    it 'should convert record(string) to hash' do
      expected_result = {
          url: "/help_page/1",
          ip: "126.318.035.038"
      }
      expect(@instance.send(:record, log_record)).to eq(expected_result)
    end
  end

  describe '#to_hash' do

    it 'should convert all log records to collection of hashes' do
      @instance.send(:to_hash)

      expected_result = [{:url=>"/help_page/1", :ip=>"126.318.035.038"},
                         {:url=>"/contact", :ip=>"184.123.665.067"},
                         {:url=>"/home", :ip=>"184.123.665.067"},
                         {:url=>"/home", :ip=>"184.123.665.055"},
                         {:url=>"/about/2", :ip=>"444.701.448.104"},
                         {:url=>"/help_page/1", :ip=>"929.398.951.889"}]
      expect(@instance.instance_variable_get(:@records)).to eq(expected_result)
    end
  end

  describe '#to_visits' do

    it 'should create instances of class Visit from array of records' do
      expected_result = 6
      @instance.send(:to_hash)
      @instance.send(:to_visits)
      expect(@instance.instance_variable_get(:@visits).count).to eq(expected_result)
      expect(@instance.instance_variable_get(:@visits).first.class).to eq(Visit)
    end
  end

  describe '#views_by' do

    let(:url) { "/help_page/1" }
    let(:url_two) { "/home" }

    it 'should select views by url attribute' do
      @instance.send(:to_hash)
      @instance.send(:to_visits)

      expect(@instance.send(:views_by, url).count).to eq(2)
      expect(@instance.send(:views_by, url).first.url).to eq(url)
      expect(@instance.send(:views_by, url_two).count).to eq(2)
      expect(@instance.send(:views_by, url_two).first.url).to eq(url_two)
    end
  end

  describe '#ip_addresses_by' do

    let(:url) { "/help_page/1" }
    let(:url_two) { "/home" }

    it 'should select ip addresses by url' do
      @instance.send(:to_hash)
      @instance.send(:to_visits)

      expected_result = ["126.318.035.038", "929.398.951.889"]
      expect(@instance.send(:ip_addresses_by, url)).to eq(expected_result)
      expected_result = ["184.123.665.067", "184.123.665.055"]
      expect(@instance.send(:ip_addresses_by, url_two)).to eq(expected_result)
    end
  end

  describe '#viewed_pages' do

    it 'should select only uniq urls from records' do
      @instance.send(:to_hash)
      @instance.send(:to_visits)

      expected_result = [{:url=>"/help_page/1", :ip=>"126.318.035.038"},
                         {:url=>"/contact", :ip=>"184.123.665.067"},
                         {:url=>"/home", :ip=>"184.123.665.067"},
                         {:url=>"/about/2", :ip=>"444.701.448.104"}]
      expect(@instance.send(:viewed_pages)).to eq(expected_result)
    end
  end


  describe '#to_pages' do

    it 'should create Page instances for viewed_pages collection' do
      @instance.send(:to_hash)
      @instance.send(:to_visits)
      @instance.send(:to_pages)

      expected_result = 4
      expect(@instance.instance_variable_get(:@pages).count).to eq(expected_result)
      expected_result = Page
      expect(@instance.instance_variable_get(:@pages).first.class).to eq(expected_result)
    end
  end
end