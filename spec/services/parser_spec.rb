# frozen_string_literal: true

describe Parser do
  describe '#parse' do
    context 'with real xml file which contains img and text posts' do
      before { allow(HTTParty).to(receive(:get).and_return(rss_stub)) }

      let(:rss_stub) do
        instance_double(
          'rss stub',
          body: File.read(File.open('spec/fixtures/files/rss.xml'))
        )
      end

      it { expect { described_class.new.parse }.to(change(News, :count).by(2)) }
    end

    context 'with stub data' do
      before do
        allow(stubbed_instance).to(receive(:xml_content).and_return(true))
        allow(stubbed_instance).to(receive(:urod_id).and_return(1))
        allow(Nokogiri).to(
          receive(:XML).and_return(
            instance_double('list items stub', search: [item_stub])
          )
        )
      end

      let(:stubbed_instance) { described_class.new }
      let(:item_stub) do
        instance_double(
          'item stub',
          at_xpath: at_xpath_stub
        )
      end
      let(:at_xpath_stub) { instance_double('xpath stub', text: 'text') }

      context 'when a news contains text information' do
        before do
          allow(Nokogiri::XML::Text).to(receive(:new))
          allow(stubbed_instance).to(receive(:img?).and_return(false))
          allow(stubbed_instance).to(
            receive(:text_content_encoded).and_return(
              instance_double(
                'text stub',
                css: [
                  instance_double('node stub', replace: true)
                ],
                text: ''
              )
            )
          )
        end

        context 'with br elements' do
          it do
            expect { stubbed_instance.parse }.to(change(News, :count).by(1))
          end
        end
      end

      context 'when a news contains img information' do
        before do
          allow(stubbed_instance).to(receive(:img?).and_return(true))
        end

        context 'when img is taken from content node' do
          before do
            allow(stubbed_instance).to(
              receive(:html_content_encoded).and_return(
                instance_double(
                  'html_content_encoded stub', at: 'img'
                )
              )
            )
          end

          let(:item_stub) do
            item = instance_double('item stub')
            allow(item).to(receive(:at_xpath).and_return(at_xpath_stub))
            allow(item).to(receive(:at_xpath).with('enclosure').and_return(nil))
            item
          end

          it do
            expect { stubbed_instance.parse }.to(change(News, :count).by(1))
          end
        end

        context 'when img is not found' do
          before do
            allow(stubbed_instance).to(
              receive(:html_content_encoded).and_return(nil)
            )
          end

          let(:item_stub) do
            item = instance_double('item stub')
            allow(item).to(receive(:at_xpath).and_return(at_xpath_stub))
            allow(item).to(receive(:at_xpath).with('enclosure').and_return(nil))
            item
          end

          it do
            expect { stubbed_instance.parse }.to(change(News, :count).by(1))
          end
        end
      end

      context 'when a news does not contain any information' do
        before do
          allow(stubbed_instance).to(receive(:img?).and_return(false))
          allow(stubbed_instance).to(receive(:text?).and_return(false))
        end

        it { expect { stubbed_instance.parse }.to(change(News, :count).by(1)) }
      end
    end
  end
end
