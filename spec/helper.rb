require "pry"

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!

  config.warnings = true
  config.default_formatter = "doc" if config.files_to_run.one?
  config.profile_examples = 10
  config.order = :random

  Kernel.srand config.seed

  $original_stderr = $stderr
  $original_stdout = $stdout

  def disable_output(&blk)
    $stderr = File.open(File::NULL, "w")
    $stdout = File.open(File::NULL, "w")
    if block_given?
      yield
      enable_output
    end
  end

  def enable_output
    $stderr = $original_stderr
    $stdout = $original_stdout
  end

end
