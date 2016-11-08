require "bundler/gem_tasks"
require 'net/http'
require_relative 'lib/biscuit/version'

def fetch(release_url)
  tgz_path       = download_file(release_url)
  this_gems_path = Gem::Specification.find_by_name('biscuit').gem_dir

  system("tar -xzf #{tgz_path} -C #{File.dirname(tgz_path)}")
  system("mv #{File.dirname(tgz_path)}/biscuit #{this_gems_path}/bin/_biscuit")
end

def download_file(url)
  uri      = URI(url)
  filename = uri.path.split('/').last

  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new uri

    http.request request do |response|
      open "/tmp/#{filename}", 'w' do |io|
        response.read_body do |chunk|
          io.write chunk
        end
      end
    end
  end

  "/tmp/#{filename}"
end

task :default do
  platform = Gem::Platform.local
  base_release_url = "https://github.com/dcoker/biscuit/releases/download/#{Biscuit::VERSION}/biscuit"

  if platform.os == 'darwin' && platform.cpu == 'x86_64'
    fetch("#{base_release_url}-darwin_amd64.tgz") 
  elsif platform.os == 'linux' && platform.cpu == 'x86_64'
    fetch("#{base_release_url}-linux_amd64.tgz") 
  else
    puts "Unsupported platform #{platform}"
  end
end
