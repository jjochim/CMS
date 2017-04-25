class AddFriendlyUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :friendly_url, :string, uniqness: true
  end
end
