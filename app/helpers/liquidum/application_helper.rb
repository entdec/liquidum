module Liquidum
  module ApplicationHelper
    def liquidum_sandboxes_menu
      Satis::Menus::Builder.build(:admin_tickets) do |m|
        m.item :create, icon: 'fal fa-plus', link: new_sandbox_path
      end
    end
  end
end
