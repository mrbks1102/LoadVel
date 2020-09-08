require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "index" do
    before { get searches_path }

    example 'リクエストが成功すること' do
      expect(response).to have_http_status(200)
    end
  end
end
