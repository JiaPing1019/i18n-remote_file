# I18n::RemoteFile

A gem builds on top of the [i18n](https://github.com/ruby-i18n/i18n) library that can support fetching translation files via HTTP rather than just relying on local translation files. It can also fall back to local translation files in case of any network issues

## Installation

- Add the following Gem to your gemfile
```ruby
gem 'i18n-remote_file', git: "https://github.com/JiaPing1019/i18n-remote_file.git"
```

- Run bundle install to install extact gem
```ruby
bundle install
```

## Usage

- Integrate the feature to the project 
```ruby
I18n::Backend::RemoteFile.config(base_url, locales_dir, files)
```

- Run HTTP server in local environment.
```
brew install http-server
cd spec/fixtures
npx http-server
```

More information can find in [http-server](https://www.npmjs.com/package/http-server)

## I18n files naming
`<language>.yml` is for the HTTP remote files, and `<language>_local.yml` is for local fallback.

## Run tests

- For all files
```ruby
rspec
```

- For specific file
```ruby
rspec path/to/spec/file.rb
```

## TODO List
The TODO items I would like to implement in the future. Each TODO item can be one task/ticket
- [ ] Improve error handling for missing arguments
- [ ] Able to retry the HTTP requests for a number of time
- [ ] Validate the file content and format from the remote HTTP is correct
- [ ] RSpec tests for each publc method, and add more tests for error cases
- [ ] Add SimpleCov gem to make sure the code coverage
- [ ] Add rubocop for the best practices and coding conventions
- [ ] Add CI to make sure the RSpec tests pass before merging into main branch
- [ ] Move `before do ... I18n.xxx ... end` block in spec into `spec/support/i18n_helper.rb` to avoid defining it several times
- [ ] Make `I18n::Backend::RemoteFile` works since it doesn't work and will raise errors at this point. Write RSpec tests to cover happy and unhappy paths
- [ ] Add SSL verification to keep data secure 

