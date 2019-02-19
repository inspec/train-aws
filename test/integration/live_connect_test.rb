# This test is like the functional tests in that it initializes
# a Connection object.  Unlike the functional tests, it uses the
# Connection to actually access AWS.

# To use this test, you must have in your ENV:
#  TODO
# To use this test, you must have in your ~/.aws/credentials:
#  TODO


require 'train'
require_relative '../helper'

describe 'Live-fire conenctions to AWS' do
  describe 'that use a variety of authentication methods' do
    # URI style - region/profile
    # profile and region in ENV
    # access key and key ID in env
    # session key
  end

  describe 'that access a variety of services' do
    {
      # 'sts' => {client: '', call: '', check: ->{|r| true } },
    }.each do |service_name, test_args|
      it "should be ale to access the '#{service_name}' service" do
      end
  end
end
