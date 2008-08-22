migration 1, :create_pages do

  up do
    create_table :pages do
      column :id, Serial
      column :url, String
      column :title, String
      column :user_id, Integer
      column :body, Text
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end

  down do
    drop_table :pages
  end

end
