# frozen_string_literal: true

describe Sender do
  describe '#send' do
    context 'when do not have news' do
      it { expect { described_class.new.send }.not_to(raise_error) }
    end

    context 'when have news' do
      before do
        allow(stubbed_instance).to(receive(:new_news).and_return([news]))
        allow(HTTParty).to(receive(:post).and_return(response_stub))
      end

      let(:stubbed_instance) { described_class.new }
      let(:response_stub) do
        instance_double('response_stub', code: 200)
      end

      context 'when a news is img news' do
        let(:news) { FactoryBot.build(:news, format: 'img') }

        it { expect { stubbed_instance.send }.not_to(raise_error) }
      end

      context 'when a news is text news' do
        let(:news) { FactoryBot.build(:news, format: 'text') }

        it { expect { stubbed_instance.send }.not_to(raise_error) }
      end

      context 'when db has news more than can' do
        before { allow(News).to(receive(:count).and_return(101)) }

        let(:news) { FactoryBot.build(:news) }

        it { expect { stubbed_instance.send }.not_to(raise_error) }
      end
    end
  end
end
