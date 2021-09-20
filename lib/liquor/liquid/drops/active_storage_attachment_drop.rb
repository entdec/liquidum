# frozen_string_literal: true

class ActiveStorage::AttachmentDrop < Liquor::Drop
  def download
    @object.download
  end

  def filename
    @object.filename.to_s
  end

  def content_type
    @object.content_type
  end

  def [](something)
    @object.send(something).to_s
  end
end
