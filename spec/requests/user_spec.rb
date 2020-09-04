require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "users/show" do
    let(:user) { create(:user) }

    example "リクエストが成功すること" do
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
