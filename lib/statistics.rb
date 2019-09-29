class Statistics

  def initialize(pages)
    @pages = pages
  end

  def popular
    @pages.sort_by {|page| page.views}.reverse
  end

  def most_uniq_views
    @pages.sort_by {|page| page.uniq_views}.reverse
  end

end