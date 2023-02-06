class CreateLiquidumSandboxes < ActiveRecord::Migration[7.0]
  def change
    create_table :liquidum_sandboxes, id: :uuid do |t|
      t.string :context
      t.string :template
      t.string :description

      t.timestamps
    end
  end
end
