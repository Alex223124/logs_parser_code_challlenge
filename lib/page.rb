class Page

  attr_reader :url, :views, :ip_addresses, :uniq_views

  def initialize(url, views, ip_addresses)
    @url = url
    @views = views
    @ip_addresses = ip_addresses.uniq
    @uniq_views = @ip_addresses.count
  end

end