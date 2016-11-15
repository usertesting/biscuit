require "biscuit/version"

module Biscuit
  def self.run!(command)
    result = `#{__dir__}/../bin/_biscuit #{command}`
    raise(result) unless $?.success?
    result
  end
end
