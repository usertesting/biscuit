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

    def exported
      @_exported ||= Biscuit.run!("export -f '#{secrets_file}'")
    end

    def secret_lines
      @_secret_lines ||= exported.split("\n").select { |line| line =~ /\S/ }
    end

    def secret_pairs
      @_secret_pairs ||= secret_lines.map { |line| line.split(":", 2).map(&:strip) }
    end

    def secrets
      @_secrets ||= Hash[secret_pairs]
    end
  end
end
