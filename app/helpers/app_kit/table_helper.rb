module AppKit::TableHelper
  def data_download_link(item, format)
    filter_label = "#{item.resource.model.name.underscore}_filter"
    link_to format.to_s.upcase,
      ak_path(item.resource.model,
              :format => format, filter_label.to_sym => params[filter_label])
  end
end
