# frozen_string_literal: true

describe News, type: :model do
  describe 'fields' do
    let(:news) { FactoryBot.build(:news).to_hash }

    it { expect(news).to(include(:urod_id)) }
    it { expect(news).to(include(:link)) }
    it { expect(news).to(include(:title)) }
    it { expect(news).to(include(:text)) }
    it { expect(news).to(include(:send_msg)) }
    it { expect(news).to(include(:format)) }
  end

  describe 'validation' do
    context 'when a record has wrong format' do
      let(:news) { FactoryBot.build(:news, format: 'wrong_value') }

      it { expect(news).not_to(be_valid) }
    end
  end

  describe '#img?' do
    context 'when a record has img format' do
      let(:news) { FactoryBot.build(:news, format: 'img') }

      it { expect(news).to(be_img) }
    end

    context 'when a record does not have img format' do
      let(:news) { FactoryBot.build(:news, format: 'none') }

      it { expect(news).not_to(be_img) }
    end
  end
end
