class CreateExpenseComments < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_comments do |t|

      t.string :sender
      t.string :reciever
      t.string :message

      t.references :expense

      t.timestamps
    end
  end
end
