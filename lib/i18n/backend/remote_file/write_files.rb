# frozen_string_literal: true

require 'fileutils'
require 'psych'

module I18n
  module Backend
    class RemoteFile
      class WriteFiles
        attr_reader :paring_files, :dir, :success_write_count, :failed_write_count

        def initialize(paring_files, dir)
          @paring_files = paring_files
          @dir = dir
          @success_write_count = 0
          @failed_write_count = 0
        end

        def write
          @paring_files.each do |filename, file_content|
            raise Errno::ENOENT if paring_files[filename].status == 404 
            file_path = File.join(dir, filename)

            File.write(file_path(dir, filename), file_content.body)
            @success_write_count += 1
          rescue Errno::ENOENT => e
            @failed_write_count += 1

            puts "Filename: #{filename}, Error: #{e.message}" 
          end

          OpenStruct.new(
            success_write_count: success_write_count,
            failed_write_count: failed_write_count,
          )
        end

        def file_path(dir, filename)
          file_path = File.join(dir, filename)
          return file_path if File.exist?(file_path)

          FileUtils.mkdir_p(dir)
          File.new(file_path, "w")
        end
      end
    end
  end
end
