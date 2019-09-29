class Report

  DEFAULT_AMOUNT_OF_RECORDS = 10
  TYPES = {
      webpages_with_most_page_views: "popular" ,
      webpages_with_most_unique_page_views: "most_uniq_views"
  }

  attr_reader :result

  def initialize(types, pages, amount_of_records = nil)
    @types = types
    @pages = pages
    @amount_of_records = amount_of_records
    @result = []
  end

  def run
    @types.each do |type|
      @result << body(type)
    end
  end

  private

  def body(type)
    title(type) +
    paragraph(type)
  end

  def title(type)
    type + ":\n"
  end

  def paragraph(type)
    result = ""
    Statistics.new(@pages).public_send(TYPES[type.to_sym])[0...amount_of_records].each do |page|
      result += record(page, type)
    end
    result
  end

  def record(page, type)
    if type == "webpages_with_most_page_views"
      "Url: #{page.url}, visits: #{page.views} \n"
    else
      "Url: #{page.url}, uniq visits: #{page.uniq_views} \n"
    end
  end

  def amount_of_records
    @amount_of_records.nil? ? DEFAULT_AMOUNT_OF_RECORDS : @amount_of_records
  end

end