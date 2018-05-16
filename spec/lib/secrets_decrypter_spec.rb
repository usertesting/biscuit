# frozen_string_literal: true

require "spec_helper"

describe Biscuit::SecretsDecrypter do
  let(:secret_file) { "/tmp/secrets.yml" }

  describe ".new" do
    subject(:decrypter) { -> { described_class.new(secret_file) } }

    context "when the file exists" do
      before { allow(File).to receive(:exists?).and_return(true) }
      it { is_expected.not_to raise_error }
    end

    context "when the file doesn't exist" do
      before { allow(File).to receive(:exists?).and_return(false) }
      it { is_expected.to raise_error(StandardError, /is not found/) }
    end
  end

  describe ".load" do
    shared_examples "translates exported data correctly" do
      let(:decrypter) { described_class.new(secret_file) }
      before { allow(File).to receive(:exists?).and_return(true) }
      before { allow(Biscuit).to receive(:run!).and_return(exported_data) }

      it "executes the correct biscuit command" do
        expect(Biscuit).to receive(:run!).with("export -f '#{secret_file}'")
        decrypter.load
      end

      context "when no block is given" do
        subject(:results) { decrypter.load }
        it { is_expected.to eq(expected_hash) }
      end

      context "when a block is given" do
        it "yields each of the expected pairs" do
          decrypter.load do |k, v|
            expect(expected_hash).to include(k => v)
          end
        end

        it "returns the expected hash" do
          expect(decrypter.load).to eq(expected_hash)
        end
      end
    end

    context "for a simple key-value pair" do
      let(:exported_data) { "secret_key: secret_value" }
      let(:expected_hash) { Hash["secret_key" => "secret_value"] }
      include_examples "translates exported data correctly"
    end

    context "for many key-value pairs" do
      let(:exported_data) do
        <<~EXPORTED
          foo: bar
          bam: baz
          one: two
        EXPORTED
      end

      let(:expected_hash) do
        {
          "foo" => "bar",
          "bam" => "baz",
          "one" => "two",
        }
      end

      include_examples "translates exported data correctly"
    end

    context "when the keys and values look numeric" do
      let(:exported_data) { "58: 49" }
      let(:expected_hash) { Hash["58" => "49"] }
      include_examples "translates exported data correctly"
    end

    context "when the values look like arrays" do
      let(:exported_data) { "foo: 1,2,3,4,5" }
      let(:expected_hash) { Hash["foo" => "1,2,3,4,5"] }
      include_examples "translates exported data correctly"
    end
  end
end
