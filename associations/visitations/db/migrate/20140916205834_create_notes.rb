class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.belongs_to :users, index: true
      t.belongs_to :projects, index: true
      t.text :content
    end
  end
end
