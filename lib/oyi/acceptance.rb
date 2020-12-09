# frozen_string_literal: true

module Oyi
  # Accept fund from yoru customers
  class Acceptance
    class << self
      # Create a payment checkout URL
      def payment_checkout(params)
        Client.request http_method: :post, endpoint: '/api/payment-checkout/create-v2', params: params
      end

      # Create a payment checkout URL with addtional details for invoicing
      def create_invoice(params)
        Client.request http_method: :post, endpoint: '/api/payment-checkout/create-invoice', params: params
      end

      # Get the status of a transaction
      def status(params)
        Client.request http_method: :get, endpoint: "/api/payment-checkout/status?#{URI.encode_www_form(params)}"
      end

      # Delete a payment/invoice link
      def delete(params)
        Client.request http_method: :delete, endpoint: "/api/payment-checkout/#{params[:payment_link_id_or_partner_tx_id]}"
      end

      # Get the details of a payment/invoice link
      def get(params)
        Client.request http_method: :get, endpoint: "/api/payment-checkout/#{params[:payment_link_id_or_partner_tx_id]}"
      end
    end
  end
end
