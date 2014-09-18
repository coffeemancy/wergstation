# encoding: UTF-8
require "spec_helper"

describe "wergstation::default" do
  it "should have better tests written" do
    expect(command "echo foo").to return_stdout(/foo/)
  end
end
