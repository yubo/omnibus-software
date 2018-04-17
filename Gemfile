source "https://rubygems.org"
gemspec

group :development, :test do
  gem "omnibus", git: "https://github.com/DataDog/omnibus-ruby.git", branch: (ENV["OMNIBUS_RUBY_VERSION"] || "datadog-5.5.0")
  gem "rake"
  gem "highline"
end
