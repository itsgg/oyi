# frozen_string_literal: true

module Oyi
  # The REST client that talks to OY API
  class Client
    class << self
      def configure(api_url:, api_username:, api_key:)
        @api_url = api_url
        @api_username = api_username
        @api_key = api_key
      end

      def configured?
        @api_url && @api_username && @api_key
      end

      def request(http_method:, endpoint:, params: nil)
        raise Error.new(message: 'Oyi client not configured') unless configured?

        begin
          response = RestClient::Request.execute method: http_method, url: "#{@api_url}/#{endpoint}",
                                                 payload: params&.to_json, headers: {
                                                   'Content-Type': 'application/json',
                                                   'Accept': 'application/json',
                                                   'X-OY-Username': @api_username,
                                                   'X-Api-Key': @api_key
                                                 }
          @code = response.code
          @message = begin
                    JSON.parse(response.body)
                     rescue JSON::ParserError
                       response.body
                  end
        rescue RestClient::RequestFailed => e
          @code = e.http_code
          @message = e.message
        end
        status = @message['status']
        if @code == HTTP_OK_CODE
          raise ApiError.new(message: @message['message']) if status == false

          custom_error_code = status.is_a?(Hash) && status['code']
          if custom_error_code && !VALID_CODES.include?(custom_error_code)
            raise ApiError.new(code: custom_error_code, message: @message)
          end

          return @message
        end

        raise error_class(@code).new(code: @code, message: @message)
      end

      def error_class(code)
        case code
        when HTTP_BAD_REQUEST_CODE
          BadRequestError
        when HTTP_UNAUTHORIZED_CODE
          UnauthorizedError
        when HTTP_FORBIDDEN_CODE
          ForbiddenError
        when HTTP_NOT_FOUND_CODE
          NotFoundError
        when HTTP_UNPROCESSABLE_ENTITY_CODE
          UnprocessableEntityError
        else
          ApiError
        end
      end
    end
  end
end
