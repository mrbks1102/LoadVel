require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:category) { create(:category) }

  describe "index" do
    before { get categories_path(category_id: category.id) }

    example "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end
  end
end
