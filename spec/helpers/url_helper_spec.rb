require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UrlHelper, type: :helper do
  context "when old subdomain is empty" do 
    url = "http://example.com"
    it "should be eq to result" do
      expect(change_subdomain(url, "", "test")).to eq("http://test.example.com")
    end
  end

  context "when old subdomain is not empty" do 
    url = "http://test.example.com"
    it "should be eq to result" do
      expect(change_subdomain(url, "test", "")).to eq("http://example.com")
    end
  end

  context "when old and new subdomain are empty" do 
    url = "http://example.com"
    it "should be eq to result" do
      expect(change_subdomain(url, "", "")).to eq("http://example.com")
    end
  end

  context "when old and new subdomain are not empty" do 
    url = "http://test.example.com"
    it "should be eq to result" do
      expect(change_subdomain(url, "test", "test-subdomain")).to eq("http://test-subdomain.example.com")
    end
  end
end
