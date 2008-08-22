migration 3, :create_users do

  up do
    create_table :users do
      column :id, Serial
      column :username, String, :size => 20
      column :password, String
      column :email, String, :size => 200
      column :display_name, String, :size => 250
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end

  down do
    drop_table :users
  end

end
