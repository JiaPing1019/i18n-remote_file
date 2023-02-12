# frozen_string_literal: true

require 'i18n/backend/remote_file/config'

RSpec.describe I18n::Backend::RemoteFile::Config do
  describe '#initialize' do
    let(:files) { ['en.yml', 'de.yml', 'fr.yml'] }

    context 'when setting is correct' do
      it 'has correct attributes' do
        config = described_class.new(base_url, locales_dir, files)

        expect(config).to have_attributes(
          base_url: 'http://localhost:8080' ,
          locales_dir: 'tmp',
          files: ['en.yml', 'de.yml', 'fr.yml'] ,
        )
      end
    end

    context 'when setting is incorrect' do
      context 'when base url is missing' do
        it 'raises an error' do
          expect {
            described_class.new('', locales_dir, files)
          }.to raise_error(described_class::MissingBaseUrlError)
        end
      end

      context 'when files is missing' do
        it 'raises an error' do
          expect {
            described_class.new(base_url, locales_dir, [])
          }.to raise_error(described_class::MissingFilesError)
        end
      end
    end
  end
end
