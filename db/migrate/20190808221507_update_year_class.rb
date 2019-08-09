class UpdateYearClass < ActiveRecord::Migration
  def change
    change_column :landmarks, :year_completed, :string
  end
end
