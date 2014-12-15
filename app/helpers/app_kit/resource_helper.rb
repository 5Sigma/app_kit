module AppKit::ResourceHelper
  def get_page
    params[:page] || 1
  end
end
