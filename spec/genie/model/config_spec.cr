require "../../spec_helper"

module Genie::Model
  describe Config do
    describe "from_file" do
      it "defaults to default config if file not found" do
        path = "/tmp/#{SecureRandom.uuid}"

        config = Config.from_file(path)
        config.username.should eq(Credentials::DEFAULT_USERNAME)
        config.password.should eq(Credentials::DEFAULT_PASSWORD)
        config.host.should eq(Config::DEFAULT_HOST)
      end

      it "defaults to default config if file is empty" do
        path = "/tmp/#{SecureRandom.uuid}"
        File.write(path, "")

        config = Config.from_file(path)
        config.username.should eq(Credentials::DEFAULT_USERNAME)
        config.password.should eq(Credentials::DEFAULT_PASSWORD)
        config.host.should eq(Config::DEFAULT_HOST)
      end

      it "loads from a file" do
        path = "/tmp/#{SecureRandom.uuid}"

        File.write(path, <<-YAML
                   credentials:
                     username: blah
                     password: pass
                   host: host
                   YAML
        )

        config = Config.from_file(path)

        config.username.should eq("blah")
        config.password.should eq("pass")
        config.host.should eq("host")
      end
    end
  end
end
