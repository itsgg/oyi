# frozen_string_literal: true

module Oyi
  HTTP_OK_CODE = 200
  HTTP_BAD_REQUEST_CODE = 400
  HTTP_UNAUTHORIZED_CODE = 401
  HTTP_FORBIDDEN_CODE = 403
  HTTP_NOT_FOUND_CODE = 404
  HTTP_UNPROCESSABLE_ENTITY_CODE = 429
  VALID_CODES = [
    '000', # Success
    '101', # Request processed
    '103' # Scheduled
  ].freeze
end
