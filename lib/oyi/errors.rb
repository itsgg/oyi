# frozen_string_literal: true

module Oyi
  # Custom Error Classes
  class Error < StandardError
    attr_accessor :status, :message

    def initialize(status: nil, message:)
      @status = status
      @message = message
    end

    def type
      self.class.name
    end
  end

  BadRequestError = Class.new(Error)
  UnauthorizedError = Class.new(Error)
  ForbiddenError = Class.new(Error)
  NotFoundError = Class.new(Error)
  UnprocessableEntityError = Class.new(Error)
  ApiError = Class.new(Error)
end
