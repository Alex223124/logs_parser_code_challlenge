class Visit

  attr_reader :url, :ip

  def initialize(url, ip)
    @url = url
    @ip = ip
  end

end