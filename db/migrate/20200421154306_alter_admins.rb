class AlterAdmins < ActiveRecord::Migration[6.0]
  def up
    add_column("admins", "username", :string, :limit => 25, :null => false, :after => "email")
    remove_column "admins", "password"
    add_column "admins", "password_digest", :string
  end

  def down
    remove_column "admins", "password_digest"
    add_column "admins", "password", :string, :limit => 40
    remove_column "admins", "username"
  end
end