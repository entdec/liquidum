class ChangeLiquidumSandboxesToText < ActiveRecord::Migration[7.0]
  def up
    change_column :liquidum_sandboxes, :context, :text
    change_column :liquidum_sandboxes, :template, :text
  end

  def down
    change_column :liquidum_sandboxes, :context, :string
    change_column :liquidum_sandboxes, :template, :string
  end
end
