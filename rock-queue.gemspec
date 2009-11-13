# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rock-queue}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Grzegorz Kazulak"]
  s.autorequire = %q{rock-queue}
  s.date = %q{2009-10-08}
  s.description = %q{A unified interface for various messaging queues}
  s.email = %q{grzegorz.kazulak@gmail.com}
  s.extra_rdoc_files = ["LICENSE"]
  s.files = ["LICENSE", "Rakefile", "lib/rock-queue", "lib/rock-queue/beanstalkd.rb", "lib/rock-queue.rb"]
  s.homepage = %q{http://github.com/grzegorzkazulak/rock-queue}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A unified interface for various messaging queues}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
