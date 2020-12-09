# frozen_string_literal: true

module Oyi
  # Allows you to disburse fund to any bank accounts in Indonesia
  class Disbursement
    class << self
      # Get beneficiary account details
      def account_inquiry(params)
        Client.request http_method: :post, endpoint: '/api/inquiry', params: params
      end

      # Start disbursing money to a specific amount
      def remit(params)
        Client.request http_method: :post, endpoint: '/api/remit', params: params
      end

      # Get status of a disbursement request
      def remit_status(params)
        Client.request http_method: :post, endpoint: '/api/remit-status', params: params
      end

      # Get partner balance
      def balance
        Client.request http_method: :get, endpoint: '/api/balance'
      end

      # Create a scheduled disbursement
      def schedule_remit(params)
        Client.request http_method: :post, endpoint: '/api/scheduled-remit', params: params
      end

      # Get the details of a scheduled remit
      def scheduled_remit_details(params)
        Client.request http_method: :get, endpoint: '/api/scheduled-remit', params: params
      end

      # Get a list of all scheduled remits
      def list_scheduled_remit
        Client.request http_method: :post, endpoint: '/api/scheduled-remit/list'
      end

      # Delete a scheduled remit
      def cancel_scheduled_remit(params)
        Client.request http_method: :delete, endpoint: '/api/scheduled-remit', params: params
      end

      # Retry a scheduled remit
      def retry_scheduled_remit(params)
        Client.request http_method: :post, endpoint: '/api/scheduled-remit/retry', params: params
      end
    end
  end
end
