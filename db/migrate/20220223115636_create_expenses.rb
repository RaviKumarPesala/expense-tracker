class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|

      t.string :name
      t.string :expense_type, default: 'I'
      t.integer :group_id, default: nil
      t.string :group_name
      t.string :invoice
      t.float :amount
      t.date :date
      t.text :description
      t.text :attachment_url
      t.string :status, default: 'pending'
      t.float :approved_amount, default: 0

      t.references :employee

      t.timestamps
    end
  end
end
