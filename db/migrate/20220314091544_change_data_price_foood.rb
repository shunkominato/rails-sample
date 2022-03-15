class ChangeDataPriceFoood < ActiveRecord::Migration[6.0]
  def change
    change_column :foods, :price, :integer
  end
end
