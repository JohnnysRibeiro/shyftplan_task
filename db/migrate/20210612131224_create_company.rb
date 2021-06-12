# frozen_string_literal: true

class CreateCompany < ActiveRecord::Migration[6.0]
  def change
    create_table :companies, id: :uuid do |t|
      t.bigint :required_employees_amount
      t.string :area_of_practice_cd
      t.uuid :parent_company_id

      t.timestamps
    end
    add_reference :companies, :parent_company_id
  end
end
