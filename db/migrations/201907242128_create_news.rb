# frozen_string_literal: true

Sequel.migration do
  up do
    create_table(:news) do
      primary_key :urod_id
      String :link
      String :title
      String :text
      Boolean :send_msg, default: false
      String :format
      Timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:news)
  end
end
