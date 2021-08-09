# frozen_string_literal: true

class Enumerator::LazyDrop < Liquor::Drop
  # FIXME: this is a workaround to make templates work as they did before, this needs to be discussed further
  def method_missing(method)
    @object.send(method)
  end

  def liquid_method_missing(method)
    @object.send(method)
  end
end
