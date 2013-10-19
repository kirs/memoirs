class CreateRubyGems < ActiveRecord::Migration
  def change
    create_table :ruby_gems do |t|
      t.string :name

      t.timestamps
    end

    add_index :ruby_gems, :name
  end
end
