RSpec::Matchers.define :have_status do |type, message = nil|

  match do |_response|
    assert_response type, message
  end

end

RSpec::Matchers.define :have_content_type do |type, message = nil|

  match do |_response|
    actual(_response).include?(type)
  end

  description do
    "has the #{ type } content type"
  end

  failure_message do |_response|
    "expected content type to be '#{ type }' but it was '#{ actual(_response) }'"
  end

  failure_message_when_negated do |_response|
    "expected content type not to be '#{ type }' but it was '#{ actual(_response) }'"
  end

  define_method :actual do |_response|
    _response.headers["Content-Type"]
  end

end

RSpec::Matchers.define :have_errors do |expected|

  match do |actual|
    errors.any?
  end

  failure_message do |actual|
    errors = formatted_errors
    message = "expected there to be errors"
    message += ", these were found:\n\n#{ errors.join("\n\n") }" if errors.any?
    message
  end

  failure_message_when_negated do |actual|
    errors = formatted_errors
    message = "expected there to be no errors"
    message += ", these were found:\n\n#{ errors.join("\n\n") }" if errors.any?
    message
  end

  def formatted_errors
    errors.map{ |e| e.to_yaml.split("\n",2).last }
  end

end