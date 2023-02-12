# frozen_string_literal: true

require "i18n/backend/transliterator"

module I18n
  module Backend
    class RemoteFile
      def self.execute(base_url, locales_dir, files)
        config = Config.new(base_url, locales_dir, files)
        files = fetch_remote_files(config)
        translate_files = translate_files(files).translations
        write_files(translate_files.translations, config.locales_dir)
        fallback_to_local_files(translate_files.fallback_list, config.locales_dir)
      end

      private

      def fetch_remote_files(config)
        I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
      end

      def translate_files(files)
        I18n::Backend::RemoteFile::TranslateFiles.new(files).translate
      end

      def write_files(translations)
        I18n::Backend::RemoteFile::WriteFiles.new(translations, temp_dir).write
      end

      def fallback_to_local_files(fallback_list)
        I18n::Backend::RemoteFile::FallbackFiles.new(fallback_list).write
      end
    end
  end
end
