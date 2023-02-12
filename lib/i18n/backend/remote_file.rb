# frozen_string_literal: true

require "i18n/backend/transliterator"

module I18n
  module Backend
    class RemoteFile
      def self.execute(base_url, locales_dir, files)
        config = Config.new(base_url, locales_dir, files)
        fetch_remote_files(config)

      end

      private

      def fetch_remote_files(config)
        res = I18n::Backend::RemoteFile::FetchFiles.new(config).fetch
      end
    end
  end
end
