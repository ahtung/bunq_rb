module BunqRb
  # Installation
  class Installation
    include BunqRb::Shared

    implements :get, :list

    attr_reader :id

    def initialize(hsh = {})
      @id = hsh["id"]
    end

    def server_public_key
      @server_public_key ||= BunqRb::InstallationServerPublicKey.new(installation_id: @id)
      @server_public_key.all.first
    end

    def self.create(hash = {})
      response = Client.send_method(:post, url, hash)
      [new(response[0]["Id"]), response[1]["Token"], response[2]["ServerPublicKey"]]
    end

    def self.url
      "/v1/installation"
    end
  end
end
