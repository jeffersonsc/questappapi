require 'spec_helper'
require 'api_constraints'

describe ApiConstraints do
	let(:api_constraints_v1) {ApiConstraints.new(version: 1)}
	let(:api_constraints_v2) {ApiConstraints.new(version: 1, default: true)}

	describe "matches?" do

		it "Return true when the version matches the 'Accept' herader" do
			request = double(host: 'api.questapp.127.0.0.1.xip.io', headers: {"Accept" => "application/vnd.questapp.v1"})
			expect(api_constraints_v1.matches?(request)).to be true
		end

		it "Return the default version when 'default' opitions is specifc" do
			request = double(host: 'api.questapp.127.0.0.1.xip.io')
			api_constraints_v2.matches?(request).should be true
		end
	end
end