require "biscuit/version"
require "biscuit/secrets_decrypter"
require "biscuit/execution_error"

require "open3"
require "yaml"

module Biscuit
  def self.run!(command)
    stdout, stderr, status = Open3.capture3("#{__dir__}/../bin/_biscuit #{command}")
    raise Biscuit::ExecutionError.new(stderr, stdout) unless status == 0
    stdout
  end
end
