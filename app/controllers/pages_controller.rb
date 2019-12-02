class PagesController < ApplicationController

  def welcome
    render layout: false
  end

  def sign_in
    liff_uid = params[:liff_uid]
    name = params[:name]
    Rails.logger.info("-----")
    Rails.logger.info("name: #{name}")
    Rails.logger.info("liff_uid: #{liff_uid}")
    Rails.logger.info("-----")
    redirect_to root_path
  end
end
