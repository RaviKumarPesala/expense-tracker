class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|

      t.string :name
      t.date :date_of_birth
      t.string :gender
      t.string :email
      t.string :mobile_number
      t.string :address
      t.string :pincode

      t.string :status, default: 'active'
      t.string :department_id, default: ''
      t.string :role, default: 'E'

      t.timestamps
    end
  end
end
