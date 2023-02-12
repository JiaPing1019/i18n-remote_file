# frozen_string_literal: true

require 'i18n/backend/remote_file/config'
require 'i18n/backend/remote_file/fetch_files'
require 'i18n/backend/remote_file/translate_files'
require 'i18n/backend/remote_file/fallback_files'
require "i18n/backend/fallbacks"

RSpec.describe I18n::Backend::RemoteFile::FallbackFiles do
  before do
    I18n.enforce_available_locales = false
    I18n.locale = :en
    I18n.default_locale = :en
    I18n.load_path += Dir[File.expand_path(temp_dir) + "/*.yml"]
  end

  describe '#fallback' do
    context 'when all files can be translated' do
      let(:files) { ['en.yml'] }

      it 'has all files in translations' do
        VCR.use_cassette('fallback_files__fackback_to_locale') do
          config = I18n::Backend::RemoteFile::Config.new(base_url, locales_dir, files)
          files = I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
          @translate_files = I18n::Backend::RemoteFile::TranslateFiles.new(files)
          @translate_files.translate
        end

        expect(@translate_files.fallback_list,).to eq(files)
        described_class.new(@translate_files.fallback_list, temp_dir).fallback
        expect(I18n.t('foo.bar.hello')).to eq('Hello local')
      end
    end
  end

  private

  def temp_dir
    'spec/fixtures/locales'
  end
end
