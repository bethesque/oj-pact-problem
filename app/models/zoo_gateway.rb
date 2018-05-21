class ZooGateway
  include HTTParty
  base_uri "localhost:7777"

  def get_aligator(name)
    self.class.get("/aligator", { query: { q: name }})
  end
end
