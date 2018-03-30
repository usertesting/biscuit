# frozen_string_literal: true

require "spec_helper"

describe Biscuit::ExecutionError do
  it { expect(described_class).to be < StandardError }

  describe "#message" do
    let(:stdout) { "standard out" }
    let(:stderr) { "standard error" }

    let(:subject) { described_class.new(stderr, stdout) }

    it "includes standard out and standard error" do
      expect(subject.message).to eq "std_out: standard out std_err: standard error"
    end

    context "when stdout is not provided" do
      let(:subject) { described_class.new(stderr) }

      it "only includes standard error" do
        expect(subject.message).to eq "std_err: standard error"
      end
    end
  end
end
