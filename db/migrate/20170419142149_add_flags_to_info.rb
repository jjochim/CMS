class AddFlagsToInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :infos, :start_mon, :datetime
    add_column :infos, :start_tue, :datetime
    add_column :infos, :start_wed, :datetime
    add_column :infos, :start_thu, :datetime
    add_column :infos, :start_fri, :datetime
    add_column :infos, :start_sat, :datetime
    add_column :infos, :start_sun, :datetime
    add_column :infos, :end_mon, :datetime
    add_column :infos, :end_tue, :datetime
    add_column :infos, :end_wed, :datetime
    add_column :infos, :end_thu, :datetime
    add_column :infos, :end_fri, :datetime
    add_column :infos, :end_sat, :datetime
    add_column :infos, :end_sun, :datetime
  end
end
