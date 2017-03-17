module BunqRb
  # PermittedIp
  class PermittedIp

    attr_reader :ip, :status

    def initialize(hsh = {})
      @ip = hsh["ip"]
      @status = hsh["status"]
    end

    def self.uri(user_id, credential_password_id)
      "/v1/user/#{user_id}/credential-password-ip/#{credential_password_id}/ip"
    end

    def self.all(user_id, credential_password_id)
      url = uri(user_id, credential_password_id)
      response = Client.send_method(:get, url)
      response.map { |resp| new(resp["PermittedIp"]) }
    end

    def self.find(id, user_id, credential_password_id)
      url = uri(user_id, credential_password_id)
      full_path = [url, id].join("/")
      response = Client.send_method(:get, full_path)
      new(response[0]["PermittedIp"])
    end
  end
end