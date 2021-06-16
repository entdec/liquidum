# frozen_string_literal: true

class ActiveStorageAttachedOneDrop < Liquor::Drop
  def download
    @object.download
  end
end
