require 'sinatra/base'
require 'json/pure'
require 'httparty'

class BOSHCliInstall < Sinatra::Base
  attr_reader :github_access_token
  attr_reader :cli_release_version

  def initialize(*args)
    super
    unless @github_access_token = ENV['GITHUB_ACCESS_TOKEN']
      $stderr.puts "Please set environment variable $GITHUB_ACCESS_TOKEN"
      $stderr.puts "Create new tokens via https://github.com/settings/applications 'Personal Access Tokens' section"
      exit 1
    end
  end

  get '/' do
    fetch_latest_release
    erb :index, format: :html5
  end

  get '/latest_version' do
    fetch_latest_release
    cli_release_version
  end


  def fetch_latest_release
    latest_cli_release = cli_releases.first
    @cli_release_tag = latest_cli_release["tag_name"]

    # strip leading v in v1.1234.0 which isn't included in download URL
    if @cli_release_tag =~ /v(.*)/
      @cli_release_version = $1
    else
      @cli_release_version = @cli_release_tag
    end
    @cli_release_name = latest_cli_release["name"]
  end

  def cli_release_name
    @cli_release_name
  end

  def cli_releases
    response = HTTParty.get(cli_releases_uri, cli_releases_headers)
    # response.body, response.code, response.message, response.headers.inspect
    JSON.parse(response.body)
  end

  def cli_releases_uri
    'https://api.github.com/repos/cloudfoundry-community/traveling-bosh/releases'
  end

  def cli_releases_headers
    raise "Must set @github_access_token first" unless github_access_token
    { headers: { "Authorization" => "token #{github_access_token}", "User-Agent" => "bosh_cli_install by Dr Nic Williams" } }
  end

  def request_hostname
    hostname = URI::Generic.build(scheme: request.scheme, host: request.host, port: request.port).to_s
    hostname.gsub(/:80/, '')
  end

  def curl_uri
    cmd = "https://raw.githubusercontent.com/cloudfoundry-community/traveling-bosh/master/scripts/installer"
    if request_hostname =~ %r{^http://bosh-cli.cloudfoundry.org}
      cmd = "#{cmd} #{request_hostname}"
    end
    cmd
  end

  # +platform+ - windows, linux, darwin
  def cli_release_asset(cli_release_assets, platform, arch = "amd64")
    cli_release_assets.find {|asset| asset["name"] =~ /#{platform}-#{arch}/ }
  end

  def cli_release_asset_windows(arch)
    cli_release_asset(@cli_release_assets, "windows", arch)
  end

  def cli_release_latest_windows(arch)
    if arch == "amd64"
      { "url" => "http://go-cli.s3.amazonaws.com/gcf-windows-amd64.zip", "name" => "gcf-windows-amd64.zip" }
    else
      { "url" => "http://go-cli.s3.amazonaws.com/gcf-windows-386.zip", "name" => "gcf-windows-386.zip" }
    end
  end

  def cli_name
    "bosh"
  end
end
