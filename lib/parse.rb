class Parse

  attr_reader :pages

  def initialize(path)
    @path = path
    @records = []
    @visits = []
    @pages = []
  end

  def run
    to_hash
    to_visits
    to_pages
  end

  private

  def record(log_record)
    {
        url: log_record.split[0],
        ip: log_record.split[1]
    }
  end

  def to_hash
    File.read(@path).each_line do |log_record|
      @records << record(log_record)
    end
  end

  def to_visits
    @records.each { |record| @visits << Visit.new(record[:url], record[:ip]) }
  end

  def views_by(url)
    @visits.select {|v| v.url == url}
  end

  def ip_addresses_by(url)
    views_by(url).map(&:ip)
  end

  def to_pages
    viewed_pages.each do |page|
      @pages << Page.new(page[:url], views_by(page[:url]).count, ip_addresses_by(page[:url]))
    end
  end

  def viewed_pages
    @records.uniq { |p| p[:url] }
  end

end