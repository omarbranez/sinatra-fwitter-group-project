class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.text :email # A string field has a limit of 255 characters, whereas a text field has a character limit of 30,000 characters.
      t.string :password_digest #so it's encrypted
    end
  end
end
