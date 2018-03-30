require "biscuit/version"
require "open3"

module Biscuit
  def self.run!(command)
    stdout, stderr, status = Open3.capture3("#{__dir__}/../bin/_biscuit #{command}")
    raise(stderr.slice(0, 200)) unless status == 0
    stdout
  end
end
