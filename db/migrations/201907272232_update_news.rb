# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:news) do
      set_column_default :send_msg, false
      set_column_default :created_at, Sequel::CURRENT_TIMESTAMP
      set_column_default :updated_at, Sequel::CURRENT_TIMESTAMP
    end
  end
end
