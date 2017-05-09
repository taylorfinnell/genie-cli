require "../spec_helper"

module Genie
  describe Credentials do
    it "can be created from yaml" do
      yaml = <<-YAML
        username: blah
        password: pass
      YAML

      credentials = Credentials.from_yaml(yaml)
      credentials.username.should eq("blah")
      credentials.password.should eq("pass")
    end

    it "defaults to admin user and pass" do
      credentials = Credentials.new

      credentials.username.should eq("admin")
      credentials.password.should eq("admin")
    end
  end
end
