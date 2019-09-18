# frozen_string_literal: true

Sequel.migration do
  up do
    alter_table(:news) do
      rename_column :send_msg, :send_tg
      add_column :send_discord, Boolean, default: false
    end
    News.where(send_tg: true).update_all(send_discord: true)
  end

  down do
    alter_table(:news) do
      drop_column :send_discord
      rename_column :send_tg, :send_msg
    end
  end
end
