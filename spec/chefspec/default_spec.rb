# encoding: UTF-8
require "spec_helper"

describe "wergstation::default" do
  # set up array of contexts to run under
  ctexts = [{ :platform => "ubuntu", :version => "14.04" }]

  ctexts.each do |ctext|
    let(:chef_run) do
      ChefSpec::Runner.new(ctext).converge("wergstation::default")
    end

    it "should include wergstation::default recipe" do
      expect(chef_run).to include_recipe("wergstation::default")
    end
  end
end
