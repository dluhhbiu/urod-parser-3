# frozen_string_literal: true

class News < Sequel::Model
  def img?
    self.format == 'img'
  end
end
