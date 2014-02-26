Gem::Specification.new do |s|
  s.name = %q{text-analysis-utils}
  s.licenses = "CC-BY-NC-SA 4.0"
  s.version = "0.5.0"
  s.required_ruby_version = ">= 2.0.0"
  s.platform = "ruby"
  s.required_rubygems_version = ">= 0"
  s.add_dependency('colorize')
  s.add_dependency('amatch')
  s.add_dependency('ruby-stemmer')
  s.add_dependency('uuid')
  s.author = "@matstc"
  s.summary = %q{Utilities to help language learners}
  s.description = %q{Utilities to help language learners}
  s.homepage = %q{http://github.com/matstc/text-analysis-utils}
  s.files = Dir["lib/*"]
  s.executables += Dir["bin/*"].map{|path|path.sub(/^bin\//,"")}
end
