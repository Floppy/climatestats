class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :shortname
      t.string :fullname
      t.string :data_uri
      t.string :info_uri
      t.integer :year_column
      t.integer :month_column
      t.integer :data_column
      t.integer :compare_to
      t.string :units

      t.timestamps
    end
  end
end
