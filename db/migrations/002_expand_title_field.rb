migration 2, :expand_title_field do

  up do
    modify_table(:pages) do
      change_column :title, String, :size => 250
    end
  end

  down do
    change_column :title, String, :size => 50
  end

end
