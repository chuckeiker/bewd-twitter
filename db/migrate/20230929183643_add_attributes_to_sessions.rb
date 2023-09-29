class AddAttributesToSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :token, :string
    add_reference :sessions, :user, null: false, foreign_key: true
  end
end
