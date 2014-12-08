module AppKit::Views
  class Base
    def table(resource, options={}, &block)
      table = Table.new(resource, options)
      items.push table
    end
  end
end
