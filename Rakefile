require 'open-uri'
require 'bundler/gem_tasks'

UPSTREAM_VERSION = '0.1.4'

def fetch(release_url)
  puts "Fetching native biscuit executable: #{release_url}"
  tgz_path = download_file(release_url)

  system("tar -xzf #{tgz_path} -C #{File.dirname(tgz_path)}") || raise
  system("mv #{File.dirname(tgz_path)}/biscuit #{__dir__}/bin/_biscuit") || raise
  puts "Successfully fetched native biscuit executable"
end

def download_file(url)
  filename = URI(url).path.split('/').last

  IO.copy_stream(URI.open(url), "/tmp/#{filename}")

  "/tmp/#{filename}"
end

task :default do
  platform = Gem::Platform.local
  base_release_url = 
    "https://github.com/dcoker/biscuit/releases/download/v#{UPSTREAM_VERSION}/biscuit_#{UPSTREAM_VERSION}_"

  if platform.os == 'darwin'
    fetch("#{base_release_url}MacOS-all.tar.gz")
  elsif platform.os == 'linux' && platform.cpu == 'x86_64'
    fetch("#{base_release_url}Linux-64bit.tar.gz")
  else
    puts "Unsupported platform #{platform}"
  end
end
