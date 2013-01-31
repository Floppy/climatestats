class AddStubToDatasets < ActiveRecord::Migration
  def change
    add_column :datasets, :stub, :string
  end
end
