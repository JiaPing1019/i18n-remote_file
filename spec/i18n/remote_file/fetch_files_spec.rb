# frozen_string_literal: true

require 'i18n/backend/remote_file/fetch_files'
require 'i18n/backend/remote_file/config'
require 'byebug'

RSpec.describe I18n::Backend::RemoteFile::FetchFiles do
  let(:config) { I18n::Backend::RemoteFile::Config.new(base_url, locales_dir, files) }

  describe '#initialize' do
    let(:files) { ['en.yml', 'de.yml', 'fr.yml'] }

    it 'initialized successfully' do
      expect { described_class.new(config) }.not_to raise_error
    end
  end

  describe '#fetch' do
    context 'when fetching successfully' do
      let(:files) { ['en.yml', 'de.yml', 'fr.yml'] }

      it 'returns 200' do
        res = nil

        VCR.use_cassette('fetch_files_successfully') do
          res = described_class.new(config).fetch
        end

        expect(res['en.yml'].status).to eq(200)
        expect(res['fr.yml'].status).to eq(200)
        expect(res['de.yml'].status).to eq(200)
      end
    end

    context 'when file is not found' do
      let(:files) { ['en.yml', 'de.yml', 'cn.yml'] }

      it 'returns 404' do
        res = nil

        VCR.use_cassette('fetch_files_failed') do
          res = described_class.new(config).fetch
        end

        expect(res['en.yml'].status).to eq(200)
        expect(res['de.yml'].status).to eq(200)
        expect(res['cn.yml'].status).to eq(404)
      end
    end
  end
end
