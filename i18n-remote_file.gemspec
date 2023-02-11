# frozen_string_literal: true

require_relative "lib/i18n/remote_file/version"

Gem::Specification.new do |spec|
  spec.name = "i18n-remote_file"
  spec.version = I18n::RemoteFile::VERSION
  spec.authors = ["JiaPing"]
  spec.email = ["jumpping4@gmail.com"]

  spec.summary = "Ruby gem that supports fetching translation files via HTTP"
  spec.description = "A ruby gem that builds on top of the i18n library which can support fetching translation files via HTTP "
  spec.homepage = "https://github.com/JiaPing1019/i18n-remote_file"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "i18n", "~> 1.12"
end
