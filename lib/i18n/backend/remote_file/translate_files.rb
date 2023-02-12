# frozen_string_literal: true

require 'i18n/backend/transliterator'
require 'i18n/backend/simple'

module I18n
  module Backend
    class RemoteFile
      class TranslateFiles
        attr_reader :files, :translations, :fallback_list

        def initialize(files)
          @files = files
          @translations = {} 
          @fallback_list = []
        end

        def translate 
          @files.each do |filename, value|
            file_status = files[filename].status

            next mark_as_fallback(filename) if file_status != 200 

            translations[filename] = value.body
          end
        end

        private
        
        def mark_as_fallback(filename)
          @fallback_list << filename 
        end
      end
    end
  end
end

