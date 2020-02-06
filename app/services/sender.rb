# frozen_string_literal: true

module Sender
  LIMIT = 100
  TELEGRAM_API = "https://api.telegram.org/bot#{ENV['BOT']}/"

  def new_records
  end

  def remove_old_news!
    extra_records = News.count - Sender::LIMIT
    return if extra_records <= 0

    ids_for_removing = News.order(:urod_id).limit(extra_records).map(&:urod_id)
    News.where(urod_id: ids_for_removing).delete
  end
end
