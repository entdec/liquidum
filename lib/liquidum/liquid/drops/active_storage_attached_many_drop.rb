# frozen_string_literal: true

class ActiveStorageAttachedManyDrop < Liquidum::Drop
  include Enumerable

  def initialize(object)
    super
    @object = @object.map { |a| ActiveStorage::AttachmentDrop.new(a) }
  end

  def each(&block)
    @object.each(&block)
  end
end
