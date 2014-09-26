class AddTimestampsToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.timestamps
    end
  end
end
