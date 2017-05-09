require "../spec_helper"

module Genie
  describe Config do
    describe "username" do
      creds = Credentials.new("u", "p")
      config = Config.new(creds)

      config.username.should eq("u")
    end

    describe "password" do
      it "returns credential password" do
        creds = Credentials.new("u", "p")
        config = Config.new(creds)

        config.password.should eq("p")
      end
    end

    describe "host" do
      it "defaults to localhost" do
        config = Config.new

        config.host.should eq("localhost")
      end
    end

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
