# frozen_string_literal: true

require "spec_helper"

describe Biscuit do
  describe ".run!" do
    let(:exit_code) { 0 }
    before do
      allow(Open3).to receive(:capture3).and_return(["secret_key: secret_value", "standard error", exit_code])
    end

    it "executes biscuit command" do
      expect(Open3).to receive(:capture3).with(/_biscuit export -f \/tmp\/secrets\.yml/)
      subject.run!("export -f /tmp/secrets.yml")
    end

    it "returns the standard output" do
      expect(subject.run!("export -f /tmp/secrets.yml")).to eq "secret_key: secret_value"
    end

    context "the command returns a non zero exit code" do
      let(:exit_code) { 1 }

      it "raises an error" do
        expect {
          subject.run!("export -f /tmp/secret.yml")
        }.to raise_error(/standard error/)
      end
    end
  end
end

