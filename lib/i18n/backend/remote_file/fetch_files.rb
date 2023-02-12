# frozen_string_literal: true

require 'faraday'

module I18n
  module Backend
    class RemoteFile
      class FetchFiles
        attr_reader :base_url, :files

        def initialize(config)
          @base_url = config.base_url
          @files = config.files
        end

        def fetch
          result = {}

          files.each { |file| result[file] = get_http_request(file) } 

          result
        end

        def get_http_request(file)
          res = connection.get(file)

          OpenStruct.new(
            status: res.status,
            body: res.body,
          )
        end

        def connection
          @connection ||= Faraday::Connection.new(base_url)
        end
      end
    end
  end
end
