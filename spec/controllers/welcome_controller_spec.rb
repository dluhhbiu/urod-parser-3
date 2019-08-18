# frozen_string_literal: true

RSpec.configure do |_|
  def app
    WelcomeController
  end
end

describe WelcomeController, type: :controller do
  describe 'GET /' do
    before { get '/' }

    it { expect(last_response.status).to(eq(200)) }
  end
end
