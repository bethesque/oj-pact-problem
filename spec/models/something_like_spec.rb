require 'pact/consumer/rspec'
require 'active_support/json'
require 'oj'

Oj.optimize_rails if ENV['OJ_ENABLED']

module Pact
  describe SomethingLike do

    let(:json) do
'
{
  "json_class": "Pact::SomethingLike",
  "contents" : { "thing" : "blah" }
}
'
    end

    describe "JSON.load" do
      subject { JSON.load(json) }

      it "creates a SomethingLike object from json" do
        expect(subject).to eq(SomethingLike.new({"thing" => "blah"}))
      end
    end
  end
end
