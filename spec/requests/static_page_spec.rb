require 'rails_helper'

RSpec.describe "Static_pages", type: :request do
  describe "index" do
    before { get static_pages_path }

    example 'リクエストが成功すること' do
      expect(response).to have_http_status(200)
    end
  end
end
