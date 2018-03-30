# frozen_string_literal: true

require "spec_helper"

describe Biscuit::SecretsDecrypter do
  let(:secret_file) { "/tmp/secrets.yml" }
  let(:subject) { described_class.new(secret_file) }

  before do
    allow(File).to receive(:exists?).and_return(true)
  end

  describe ".new" do
    it "checks if the file exists" do
      expect(File).to receive(:exists?)
      subject
    end

    context "if file doesn't exist" do
      it "raises an error" do
        allow(File).to receive(:exists?).and_return(false)
        expect {
          subject
        }.to raise_error
      end
    end
  end

  describe ".load" do
    before do
      allow(Biscuit).to receive(:run!).and_return("secret_key: secret_value")
    end

    it "executes biscuit command" do
      expect(Biscuit).to receive(:run!).with("export -f /tmp/secrets.yml")
      subject.load
    end

    it "returns a hash" do
      expect(subject.load).to eq({"secret_key"=>"secret_value"})
    end

    context "when a block is given" do
      it "returns key and value" do
        my_hash = {}
        subject.load do |key, value|
          my_hash[key] = value
        end

        expect(my_hash).to eq({"secret_key"=>"secret_value"})
      end
    end
  end
end
