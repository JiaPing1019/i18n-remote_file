# I18n::RemoteFile

A gem builds on top of the [i18n](https://github.com/ruby-i18n/i18n) library that can support fetching translation files via HTTP rather than just relying on local translation files. It can also fall back to local translation files in case of any network issues

## Installation

- Add the following Gem to your gemfile
```
gem 'i18n-remote_file', git: "https://github.com/JiaPing1019/i18n-remote_file.git"
```

- Run bundle install to install extact gem
```
bundle install
```

## Usage

- Integrate the feature to the project 
```
I18n::Backend::RemoteFile.config(base_url, locales_dir, files)
```

- Run HTTP server in local environment.
```
brew install http-server
cd spec/fixtures
npx http-server
```

More information can find in [http-server](https://www.npmjs.com/package/http-server)


## Run tests

- For all files
```
rspec
```

- For specific file
```
rspec path/to/spec/file.rb
```
