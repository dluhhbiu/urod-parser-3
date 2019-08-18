# frozen_string_literal: true

describe WithCreatedAt do
  describe '#before_create' do
    let(:news) { FactoryBot.build(:news) }

    it { expect(news.created_at).to(be_nil) }
    it { expect(news.updated_at).to(be_nil) }
  end

  describe '#after_create' do
    let(:news) { FactoryBot.create(:news) }

    it { expect(news.created_at).not_to(be_nil) }
    it { expect(news.updated_at).not_to(be_nil) }
  end

  describe '#after_update' do
    let(:news) { FactoryBot.create(:news) }

    it 'updated_at is changed' do
      updated_at = news.updated_at
      news.update(title: 'new title')
      expect(news.updated_at).not_to(eq(updated_at))
    end
  end
end
