# frozen_string_literal: true

require 'i18n/backend/remote_file/config'
require 'i18n/backend/remote_file/fetch_files'
require 'i18n/backend/remote_file/translate_files'
require 'i18n/backend/remote_file/write_files'

RSpec.describe I18n::Backend::RemoteFile::WriteFiles do
  describe '#write' do
    context 'when writing successfully' do
      let(:files) { ['en.yml', 'de.yml', 'fr.yml'] }

      it 'no errors' do
        VCR.use_cassette('write_files__parsing_files') do
          config = I18n::Backend::RemoteFile::Config.new(base_url, locales_dir, files)
          files = I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
          @translate_files = I18n::Backend::RemoteFile::TranslateFiles.new(files)
        end
        
        res = described_class.new(@translate_files.translate, temp_dir).write
        expect(res.success_write_count).to eq(files.size)
        expect(res.failed_write_count).to eq(0)
      end
    end

    context 'when fail to write' do
      let(:files) { ['en.yml', 'cn.yml'] }
      
      it 'shows error' do
         VCR.use_cassette('write_files__having_missing_file') do
          config = I18n::Backend::RemoteFile::Config.new(base_url, locales_dir, files)
          files = I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
          @translate_files = I18n::Backend::RemoteFile::TranslateFiles.new(files)
        end

        res = described_class.new(@translate_files.translate, temp_dir).write

        expect(res.success_write_count).to eq(1)
        expect(res.failed_write_count).to eq(1)
      end
    end
  end

  private

  def temp_dir 
    "spec/fixtures/remote/tmp"
  end
end
