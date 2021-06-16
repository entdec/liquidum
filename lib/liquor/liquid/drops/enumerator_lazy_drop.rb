# frozen_string_literal: true

class Enumerator::LazyDrop < Liquor::Drop
  def liquid_method_missing(method)
    @object.send(method)
  end
end
