module BunqRb
  # DeviceServer
  class DeviceServer
    URI = "/v1/device-server".freeze

    def initialize(hsh = {})
      @id = hsh["id"]
    end

    def self.create(hash = {})
      faraday_response = Client.connection.post(URI, hash)
      json_response = JSON.parse(faraday_response.body)
      raise json_response["Error"].first["error_description"] if json_response.key?("Error")
      new(json_response["Response"].first["Id"])
    end
  end
end
