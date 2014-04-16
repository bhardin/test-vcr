require 'webmock'
require 'rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe "query.kissmetrics.com" do
  let(:uri) { URI.parse("https://query.kissmetrics.com") }

    it "responds to /" do
      VCR.use_cassette('root_request') do
        response = Net::HTTP.get_response(uri)
        expect(JSON.parse(response.body)).to eq({ "title" => "KISSmetrics Query API" })
      end
    end
end