require "spec_helper"

describe BunqRb::Card, active_session: true do
  it_behaves_like "get", [1, 11]
  it_behaves_like "list", [1]
end
