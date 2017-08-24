module RequestSpecHelper
  # Parse JSON response to ruby hash to make it easier to test
  def json
    JSON.parse(response.body)
  end
end