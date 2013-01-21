class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.float :value
      t.date :measured_on
      t.references :dataset

      t.timestamps
    end
    add_index :measurements, :dataset_id
  end
end
