# frozen_string_literal: true

module WithCreatedAt
  private

  def before_create
    self.created_at = Time.now
    self.updated_at = Time.now
    super
  end

  def before_update
    self.updated_at = Time.now
    super
  end
end
