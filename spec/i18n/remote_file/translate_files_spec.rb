# frozen_string_literal: true

require 'i18n/backend/remote_file/config'
require 'i18n/backend/remote_file/fetch_files'
require 'i18n/backend/remote_file/translate_files'

RSpec.describe I18n::Backend::RemoteFile::TranslateFiles do
  before do
    I18n.enforce_available_locales = false
    I18n.available_locales = []
    I18n.locale = :en
    I18n.default_locale = :en
    I18n.load_path = []
  end

  describe '#translate' do
    context 'when all files can be translated' do
      let(:files) { ['en.yml', 'de.yml', 'fr.yml'] }

      it 'has all files in translations' do
        VCR.use_cassette('translate_successfully') do
          config = I18n::Backend::RemoteFile::Config.new(base_url, locales_dir, files)
          files = I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
          @translate_files = described_class.new(files)
          res = @translate_files.translate
        end

        expect(@translate_files.translations).to eq(
          {
            "en.yml" => test_en_body,
            "de.yml" => test_de_body,
            "fr.yml" => test_fr_body, 
          }
        )

        expect(@translate_files.fallback_list).to eq([])
      end
    end

    context 'when fackback file exists' do
      let(:files) { ['en.yml', 'cn.yml'] }

      it 'has file in fallback list' do
        VCR.use_cassette('translate_partially_successfully') do
          config = I18n::Backend::RemoteFile::Config.new(base_url, locales_dir, files)
          files = I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
          @translate_files = described_class.new(files)
          res = @translate_files.translate
        end

        expect(@translate_files.translations).to eq(
          {
            "en.yml" => test_en_body,
          }
        )

        expect(@translate_files.fallback_list).to eq(['cn.yml'])
      end
    end
  end
end
