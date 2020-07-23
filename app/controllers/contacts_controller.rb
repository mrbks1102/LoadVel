class ContactsController < ApplicationController
  def new
  end

  def create
    @contact = Contact.create(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
    end
    redirect_to root_path
    flash[:notice] = "問い合わせ内容を送信しました。"
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :body)
  end
end
