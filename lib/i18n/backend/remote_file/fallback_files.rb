# frozen_string_literal: true

require 'psych'
require "i18n/backend/base"
require 'byebug'

module I18n
  module Backend
    class RemoteFile
      class FallbackFiles
        attr_reader :fallback_list, :dir

        def initialize(fallback_list, dir)
          @fallback_list = fallback_list
          @dir = dir
        end
        
        def fallback
          fallback_list.each do |file|
            filename, filetype  = file.split('.')
            file_path = File.join(dir, "#{filename}_local.#{filetype}") 

            unless File.exist?(file_path) 
              puts  "#{file} does not exist" 
              next
            end

            data = deep_symbolize_keys(Psych.load_file(file_path))
            I18n.backend.store_translations(filename, data[filename.to_sym])
          end
        end

        def deep_symbolize_keys(data)
          I18n::Utils.deep_symbolize_keys(data)
        end
      end
    end
  end
end
