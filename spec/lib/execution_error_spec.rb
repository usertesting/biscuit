# frozen_string_literal: true

require "spec_helper"

describe Biscuit::ExecutionError do
  it { expect(described_class).to be < StandardError }

  describe "#message" do
    let(:stdout) { "standard out" }
    let(:stderr) { "standard error" }

    let(:subject) { described_class.new(stdout, stderr) }

    it "includes standard out and standard error" do
      expect(subject.message).to eq "std_out: standard out std_err: standard error"
    end
  end
end
