require "rails_helper"

RSpec.describe "Contacts", type: :request do
  let(:user) { create(:user) }

  let(:contact_params) { { name: "name", email: "mail@mail.com", body: "body" } }

  describe "new" do
    before { get new_contact_path }

    example "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end
  end

  describe "create" do
    context 'ログイン時' do
      before { sign_in user }

      example "正常にメールを送信できること" do
        expect do
          post contacts_path, params: { contact: contact_params }
        end.to change(Contact, :count).by(1)
      end
    end

    context "非ログイン時" do
      example '正常にメールを送信できること' do
        expect do
          post contacts_path, params: { contact: contact_params }
        end.to change(Contact, :count).by(1)
      end
    end

    context "メール送信後" do
      before { post contacts_path, params: { contact: contact_params } }

      example "トップページへリダイレクトされること" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
