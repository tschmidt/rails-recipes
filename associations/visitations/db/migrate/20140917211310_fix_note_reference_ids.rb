class FixNoteReferenceIds < ActiveRecord::Migration
  def change
    change_table :notes do |t|
      t.remove :projects_id
      t.remove :users_id
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
    end
  end
end
