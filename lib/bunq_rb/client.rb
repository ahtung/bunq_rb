require "securerandom"
require "faraday"
require "faraday_middleware"

require_relative "client/headers"
require_relative "client/sign_request"

module BunqRb
  # Shared
  # TODO: (dunyakirkali) Extract to file
  module Shared
    extend ActiveSupport::Concern

    module ClassMethods
      def implements(*calls)
        calls.each do |call|
          case call
          when :get
            implements_get
          when :list
            implements_list
          when :delete
            implements_delete
          else
            puts "ERROR for: #{call}"
          end
        end
      end

      private

      def implements_delete
        define_singleton_method(:delete) do |*args|
          id = args.pop
          full_uri = [url(*args), id].join("/")
          response = Client.send_method(:delete, full_uri)
          []
        end
      end

      def implements_get
        define_singleton_method(:find) do |*args|
          id = args.pop
          full_uri = [url(*args), id].join("/")
          response = Client.send_method(:get, full_uri)
          new(response[0].values.first)
        end
      end

      def implements_list
        define_singleton_method(:all) do |*args|
          Enumerator.new do |yielder|
            older_url = counted_url(args)
            loop do
              results = Client.raw_send_method(:get, older_url)
              json = JSON.parse(results.body)
              json["Response"].map { |item| yielder << new(item.values.first) }
              raise StopIteration if json["Pagination"].nil? || json["Pagination"]["older_url"].nil?
              older_url = json["Pagination"]["older_url"]
            end
          end.lazy
        end
      end

      def counted_url(args)
        page_size = BunqRb.configuration.page_size
        arged_url = Addressable::Template.new("#{url(*args)}{?query*}")
        params = page_size == 10 ? {} : { count: page_size }
        arged_url.expand(query: params).to_s
      end
    end
  end
end

Dir[File.dirname(__FILE__) + "/objects/**/*.rb"].each { |f| require f }

module BunqRb
  # Client
  class Client
    def self.connection
      @connection ||= Faraday.new(url: BunqRb.configuration.url) do |config|
        config.use Headers
        config.use SignRequest
        config.request :json
        config.request :multipart
        config.adapter Faraday.default_adapter
      end
    end

    def self.send_method(method, url, payload = {})
      BunqRb.logger.debug "#{method.upcase} #{url}"
      faraday_response = connection.send(method, url, payload)
      json_response = JSON.parse(faraday_response.body)
      raise json_response["Error"].first["error_description"] if json_response.key?("Error")
      json_response["Response"]
    end

    def self.raw_send_method(method, url, payload = {})
      BunqRb.logger.debug "#{method.upcase} #{url}"
      connection.send(method, url, payload)
    end
  end
end
