# frozen_string_literal: true

RSpec.describe Oyi::Client do
  it '.request throws exception if the client is not configured' do
    Oyi::Client.configure api_url: nil, api_username: nil, api_key: nil
    expect do
      Oyi::Client.request http_method: :post, endpoint: '/api/'
    end.to raise_error(Oyi::Error)
  end
end
