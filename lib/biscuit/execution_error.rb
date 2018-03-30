# frozen_string_literal: true

module Biscuit
  class ExecutionError < StandardError
    def initialize(stderr, stdout=nil)
      @stdout = stdout
      @stderr = stderr
      super(message)
    end

    def message
      messages = []
      messages << "std_out: #{truncate(@stdout)}" if @stdout
      messages << "std_err: #{truncate(@stderr)}" if @stderr
      messages.join(" ")
    end

    private

    def truncate(message)
      message.slice(0, 200)
    end
  end
end
