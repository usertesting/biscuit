require 'bundler'
require 'bundler/gem_tasks'
require 'open-uri'

UPSTREAM_VERSION = '0.1.2'

def fetch(release_url)
  tgz_path = download_file(release_url)

  system("tar -xzf #{tgz_path} -C #{File.dirname(tgz_path)}") || raise
  system("mv #{File.dirname(tgz_path)}/biscuit #{__dir__}/bin/_biscuit") || raise
end

def download_file(url)
  filename = URI(url).path.split('/').last

  IO.copy_stream(open(url), "/tmp/#{filename}")

  "/tmp/#{filename}"
end

task :default do
  platform = Gem::Platform.local
  base_release_url = "https://github.com/dcoker/biscuit/releases/download/v#{UPSTREAM_VERSION}/biscuit"

  if platform.os == 'darwin' && platform.cpu == 'x86_64'
    fetch("#{base_release_url}-darwin_amd64.tgz") 
  elsif platform.os == 'linux' && platform.cpu == 'x86_64'
    fetch("#{base_release_url}-linux_amd64.tgz") 
  else
    puts "Unsupported platform #{platform}"
  end
end
