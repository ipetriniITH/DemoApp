class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string 'email', default: 'default@email.com', null: false
      t.string 'password', :limit => 40
      
      t.timestamps
    end
  end
end
