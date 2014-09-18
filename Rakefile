# encoding: UTF-8
require "bundler/setup"
require "English"

## Style checking
#
namespace :style do
  begin
    require "rubocop/rake_task"
    desc "Run Ruby style checks"
    RuboCop::RakeTask.new(:ruby)
  rescue LoadError
    "#{$ERROR_INFO} -- rubocop tasks not loaded!"
  end

  begin
    require "foodcritic"
    desc "Run Chef style checks"

    FoodCritic::Rake::LintTask.new(:chef) do |t|
      t.options = {
        :fail_tags => %w{ any },
        :tags => %w{} }
    end
  rescue LoadError
    "#{$ERROR_INFO} -- foodcritic tasks not loaded!"
  end
end

desc "Run all style checks"
task :style => ["style:chef", "style:ruby"]

## Unit tests
#
### Determine which spec tests to run
#
# Without this, due to RSpec funny business, when a pattern is missing, will
# default to running all tests, which chokes on any serverspec files.
#
specs = %w{ chefspec rspec }.select { |s| ::File.exist?("spec/#{s}") }

namespace :unit do
  begin
    require "rspec/core/rake_task"

    specs.each do |spec_type|
      desc "Run #{spec_type} checks"
      RSpec::Core::RakeTask.new(spec_type.to_sym) do |t|
        t.pattern = "spec/#{spec_type}/*_spec.rb"
        t.rspec_opts = "--color --format documentation"
        t.ruby_opts = %w{ -W0 }
      end
    end
  rescue LoadError
    "#{$ERROR_INFO} -- spec tasks not loaded!"
  end
end

desc "Run all unit tests"
task :unit => specs.map { |s| "unit:#{s}" }

begin
  require "kitchen"

  desc "Run Test Kitchen integration tests"
  task :integration do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
rescue LoadError
  warn "#{$ERROR_INFO} -- kitchen tasks not loaded!"
end

# The default rake task
task :default => %w{style unit}
