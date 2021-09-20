# frozen_string_literal: true

class ActiveStorageAttachedOneDrop < Liquor::Drop
  def download
    @object.download
  end

  def filename
    @object.filename.to_s
  end

  def content_type
    @object.content_type
  end
end
