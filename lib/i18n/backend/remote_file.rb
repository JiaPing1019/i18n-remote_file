# frozen_string_literal: true

require "i18n/backend/transliterator"

module I18n
  module Backend
    class RemoteFile
      def self.execute(base_url, locales_dir, files)
        config = Config.new(base_url, locales_dir, files)
        files = fetch_remote_files(config)
        translations = translate_files(files).translations
        fallback_list = translate_files(files).fallback_list 
      end

      private

      def fetch_remote_files(config)
        I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
      end

      def translate_files(files)
        I18n::Backend::RemoteFile::TranslateFiles.new(files).translate
      end
    end
  end
end
