class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :ruby_gem, index: true

      t.string :number

      t.integer :major, default: 0
      t.integer :minor, default: 0
      t.integer :patch, default: 0

      t.text :release_notes

      t.timestamps
    end

    add_index :versions, %w(major minor patch)
    add_index :versions, %w(ruby_gem_id number), unique: true
  end
end
