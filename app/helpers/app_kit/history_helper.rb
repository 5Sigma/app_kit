module AppKit::HistoryHelper
  def version_url(version)
    if version.index == version.item.versions.length - 1
      ak_path(version.item)
    else
      polymorphic_path([app_kit, :version, version.item],
                       version_id: version.index + 1)
    end
  end
  def show_version_path(record, version, count)
    if version.index == record.versions.length - 1
      ak_path(record)
    else
      polymorphic_path([app_kit, :version, @record],
                       version_id: version.index + 1)
    end
  end
end
