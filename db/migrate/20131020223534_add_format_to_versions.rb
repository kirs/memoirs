class AddFormatToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :file_extension, :string
  end
end
