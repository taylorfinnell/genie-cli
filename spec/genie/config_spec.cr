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
      it "can parse columns" do
        path = "/tmp/#{SecureRandom.uuid}"

        File.write(path, <<-YAML
                   columns:
                     - id
                     - status
                   YAML
        )

        config = Config.from_file(path)

        config.columns.should eq(["id", "status"])
      end

      it "defaults to empty column list" do
        path = "/tmp/#{SecureRandom.uuid}"

        config = Config.from_file(path)

        config.columns.should eq([] of String)
      end

      it "defaults to nil printer" do
        path = "/tmp/#{SecureRandom.uuid}"

        config = Config.from_file(path)
        config.printer.should eq(nil)
      end

      it "can set printer" do
        path = "/tmp/#{SecureRandom.uuid}"

        File.write(path, <<-YAML
                   printer: tabbed
                   YAML
        )

        config = Config.from_file(path)

        config.printer.should eq("tabbed")
      end

      it "defaults to default config if file not found" do
        path = "/tmp/#{SecureRandom.uuid}"

        config = Config.from_file(path)
        config.username.should eq(nil)
        config.password.should eq(nil)
        config.host.should eq(Config::DEFAULT_HOST)
      end

      it "defaults to nil credentials" do
        path = "/tmp/#{SecureRandom.uuid}"

        config = Config.from_file(path)
        config.credentials.should eq(nil)
      end

      it "defaults to default config if file is empty" do
        path = "/tmp/#{SecureRandom.uuid}"
        File.write(path, "")

        config = Config.from_file(path)
        config.username.should eq(nil)
        config.password.should eq(nil)
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
