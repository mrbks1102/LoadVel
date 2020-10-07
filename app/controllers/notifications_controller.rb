class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(8).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.js
    end
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
