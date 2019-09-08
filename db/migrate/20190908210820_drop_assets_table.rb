class DropAssetsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :assets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
