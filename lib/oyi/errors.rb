# frozen_string_literal: true

module Oyi
  # Custom Error Classes
  class Error < StandardError
    attr_accessor :code, :message

    def initialize(code: nil, message:)
      @code = code
      @message = message
    end
  end

  BadRequestError = Class.new(Error)
  UnauthorizedError = Class.new(Error)
  ForbiddenError = Class.new(Error)
  NotFoundError = Class.new(Error)
  UnprocessableEntityError = Class.new(Error)
  ApiError = Class.new(Error)
end
