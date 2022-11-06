# frozen_string_literal: true

class ActiveStorageAttachedOneDrop < Liquidum::Drop
  def download
    @object.download
  end

  def filename
    @object.filename.to_s
  end

  def content_type
    @object.content_type
  end

  def to_io
    return unless @object.attached?

    StringIO.new(@object.download)
  end
end
