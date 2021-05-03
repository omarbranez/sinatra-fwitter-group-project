class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.text :content # A string field has a limit of 255 characters, whereas a text field has a character limit of 30,000 characters.
      t.integer :user_id
      t.timestamps(null:false) #tweets have timestamps!
    end
  end
end
