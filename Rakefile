require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'spec/rake/spectask'
require 'date'
$LOAD_PATH.unshift 'lib'
require 'rock-queue/tasks'

GEM = "rock-queue"
GEM_VERSION = "0.3.0"
SUMMARY = "A unified interface for various messaging queues"
AUTHORS = ["Grzegorz Kazulak"]
EMAIL = "gregorz.kazulak@gmail.com"
HOMEPAGE = "http://github.com/grzegorzkazulak/rock-queue"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = GEM
    gem.version = GEM_VERSION
    gem.summary = SUMMARY
    gem.description = SUMMARY
    gem.email = EMAIL
    gem.homepage = HOMEPAGE
    gem.authors = AUTHORS
    
    # Dependencies
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_dependency "resque", ">= 1.9.9"
    gem.add_dependency "mail", ">= 2.2.5"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    
    gem.require_path = 'lib'
    gem.autorequire = GEM
    gem.files = %w(LICENSE Rakefile) + Dir.glob("{lib,specs}/**/*")
    gem.platform = Gem::Platform::RUBY
    gem.has_rdoc = true
    gem.extra_rdoc_files = ["LICENSE"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :default => :spec 
 
desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "Run all examples" 
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts  = ["-cfs"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  t.spec_opts  = ["-cfs"]
  t.rcov = true
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov_opts = ['--exclude spec,/home']
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rock-queue #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
