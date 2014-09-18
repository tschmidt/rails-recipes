class CreateVisitations < ActiveRecord::Migration
  def change
    create_table :visitations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end
