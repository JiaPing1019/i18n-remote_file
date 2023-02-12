# frozen_string_literal: true

module I18n
  module Backend
    class RemoteFile 
      class Config
        class MissingBaseUrlError < StandardError; end
        class MissingFilesError < StandardError; end

        attr_accessor :base_url, :locales_dir, :files

        DEFAULT_LOCALES_DIR =  'config/locales'.freeze 

        def initialize(base_url, locales_dir, files)
          @base_url = base_url 
          @files = files
          @locales_dir = locales_dir || DEFAULT_LOCALES_DIR 

          raise MissingBaseUrlError if base_url.nil? || base_url.empty? 
          raise MissingFilesError if files.nil? || files.empty? 
        end
      end
    end
  end
end
