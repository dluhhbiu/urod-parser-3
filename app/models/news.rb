# frozen_string_literal: true

class News < Sequel::Model
  include WithCreatedAt

  def img?
    self.format == 'img'
  end
end
