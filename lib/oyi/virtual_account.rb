# frozen_string_literal: true

module Oyi
  # Use unique Virutal Account number as a payment method for your customers
  class VirtualAccount
    class << self
      # Create a new VA number
      def create(params)
        Client.request http_method: :post, endpoint: '/api/generate-static-va', params: params
      end

      # Get VA details
      def get(id)
        Client.request http_method: :get, endpoint: "/api/static-virtual-account/#{id}"
      end

      # Update existing VA
      def update(id, params)
        Client.request http_method: :put, endpoint: "/api/static-virtual-account/#{id}", params: params
      end

      # Get all VAs
      def all(params = {})
        Client.request http_method: :get, endpoint: "/api/static-virtual-account?#{URI.encode_www_form(params)}"
      end

      # Get all transactions for a VA
      def transactions(id, params = {})
        Client.request http_method: :get, endpoint: "/api/va-tx-history/#{id}?#{URI.encode_www_form(params)}"
      end
    end
  end
end
