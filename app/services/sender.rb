# frozen_string_literal: true

require 'httparty'

class Sender
  LIMIT = 100
  API = "https://api.telegram.org/bot#{ENV['BOT']}/"

  def send
    new_news.each do |n|
      data = prepare(n)
      n.update(send_msg: true) if send_news(data)
    end

    remove_old_news
  end

  private

  def new_news
    News.where(send_msg: false).order(:urod_id)
  end

  def prepare(record)
    if record.img?
      prepare_img(record)
    else
      prepare_text(record)
    end
  end

  def prepare_img(record)
    {
      action: 'sendPhoto',
      data: {
        photo: record.text,
        caption: "#{record.title}\n#{record.link}"
      }
    }
  end

  def prepare_text(record)
    {
      action: 'sendMessage',
      data: {
        text: "*#{record.title}*\n#{record.text}\n#{record.link}",
        parse_mode: 'markdown'
      }
    }
  end

  def send_news(data)
    data[:data][:chat_id] = ENV['CHAT_ID']
    url = API + data[:action]
    response = HTTParty.post(url, body: data[:data])
    response.code == 200
  end

  def remove_old_news
    extra_records = News.count - LIMIT
    return if extra_records <= 0

    ids_for_removing = News.order(:urod_id).limit(extra_records).map(&:urod_id)
    News.where(urod_id: ids_for_removing).delete
  end
end
