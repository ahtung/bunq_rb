module BunqRb
  # DeviceServer
  class DeviceServer
    include BunqRb::Shared

    implements :get, :list

    attr_reader :id

    def initialize(hsh = {})
      @id = hsh["id"]
    end

    def self.url
      "/v1/device-server"
    end

    def self.create(hash = {})
      response = Client.send_method(:post, url, hash)
      new(response[0]["Id"])
    end
  end
end
