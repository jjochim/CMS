class AddFlagsToSeance < ActiveRecord::Migration[5.0]
  def change
    add_column :seances, :block, :boolean
  end
end
