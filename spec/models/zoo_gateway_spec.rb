require 'pact/consumer/rspec'

Oj.optimize_rails if ENV['OJ_ENABLED']

describe ZooGateway, { pact: true } do
  let(:zoo_gateway) { ZooGateway.new }

  before(:all) do
    Pact.service_consumer "pact-test" do
      has_pact_with "zoo" do
        mock_service :pact_zoo_gateway do
          port "7777"
          pact_specification_version "2.0.0"
        end
      end
    end
  end

  describe "#fetch" do
    before do
      ZooGateway.base_uri "localhost:7777"

      x = pact_zoo_gateway
        .given("an aligator exists")
        .upon_receiving("a request for an alligator")
        .with(method: :get,
          path: "/aligator",
          query: { q: Pact.like("gator") })
        .will_respond_with(
          status: 200,
          headers: { content_type: { 'Content-Type' => Pact.term(generate: 'application/json; charset=utf-8', matcher: /application\/json/) } },
          body: { aligators: [{ name: "gator" }] }
        )

      puts x.to_json
    end

    it do
      expect(zoo_gateway.get_aligator("gator")).not_to be_nil
    end
  end


end
