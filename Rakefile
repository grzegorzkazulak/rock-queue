require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'spec/rake/spectask'
require 'date'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require 'rock-queue/tasks'
 
GEM = "rock-queue"
GEM_VERSION = "0.1.7"
AUTHOR = "Grzegorz Kazulak"
EMAIL = "gregorz.kazulak@gmail.com"
HOMEPAGE = "http://github.com/grzegorzkazulak/rock-queue"
SUMMARY = "A unified interface for various messaging queues"
 
spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE Rakefile) + Dir.glob("{lib,specs}/**/*")
end
 
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
 
desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end
 
desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
 
desc "Run all examples (or a specific spec with TASK=spec/some_file.rb)"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts  = ["-cfs"]
  t.spec_files = begin
    if ENV["TASK"] 
      ENV["TASK"].split(',').map { |task| "spec/**/#{task}_spec.rb" }
    else
      FileList['spec/**/*_spec.rb']
    end
  end
end