# frozen_string_literal: true

module Oyi
  # Handles beneficiary account details
  class Account
    class << self
      # Get beneficiery account details
      def inquiry(params)
        Client.request http_method: :post, endpoint: '/api/account-inquiry', params: params
      end
    end
  end
end
