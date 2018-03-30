# frozen_string_literal: true

module Biscuit
  class SecretsDecrypter
    attr_reader :secrets_file

    def initialize(secrets_file)
      fail "#{secrets_file} is not found" unless File.exists? secrets_file

      @secrets_file = secrets_file
    end

    def load(&block)
      if block_given?
        secrets.each{ |key, value|
          block.call(key, value)
        }
      else
        secrets
      end
    end

    private

    def secrets
      return @secrets if defined? @secrets

      result   = Biscuit.run!("export -f #{secrets_file}")
      @secrets = YAML.load(result)
    end
  end
end
