class AppKit::AssociationCollection
  include Enumerable

  attr_reader :has_many_associations
  attr_reader :has_many_through_associations
  attr_reader :belongs_to_associations


  def initialize
    @has_many_through_associations = []
    @has_many_associations = []
    @belongs_to_associations = []
  end

  def add(assoc)
    case assoc.association_type
    when :has_many
      @has_many_associations.push assoc
    when :has_many_through
      @has_many_through.push assoc
    when :belongs_to
      @belongs_to.push assoc
    end
  end

  def each
    @has_many_associations.each { |i| yield i}
    @belongs_to_associations.each { |i| yield i}
    @has_many_through_associations.each { |i| yield i}
  end
end
