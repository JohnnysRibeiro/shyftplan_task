class CreateEmployee < ActiveRecord::Migration[6.0]
  def change
    create_table :employees, id: :uuid do |t|
      t.references :company, type: :uuid

      t.timestamps
    end
  end
end
