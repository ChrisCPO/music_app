module SearchHelper
  def search_form
    @search || Search.new
  end
end
