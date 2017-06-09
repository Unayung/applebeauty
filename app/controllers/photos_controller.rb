# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: photos
#
#  id                     :integer          not null, primary key
#  file                   :string(255)
#  link_id                :integer
#  file_width             :string(255)
#  file_height            :string(255)
#  file_image_size        :string(255)
#  file_content_type      :string(255)
#  file_tiny_width        :string(255)
#  file_tiny_height       :string(255)
#  file_tiny_image_size   :string(255)
#  file_tiny_content_type :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class PhotosController < ApplicationController
  before_filter :find_link

  def new 
    @object_new = @link.photos.build    # needed for form_for --> gets the path
  end

  def index
    @photos = @link.photos

    render :json => @photos.collect { |p| p.to_jq_upload }.to_json
  end

  def create
    @photo = @link.photos.build
    @photo.file = params[:link_photos][:file]
    if @photo.save
      @photo.link.update_attribute(:appeal, true)
      respond_to do |format|
        format.html {                                         #(html response is for browsers using iframe sollution)
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@photo.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render :json => true
  end
  protected

  def find_link
    @link = Link.friendly.find(params[:link_id])
  end
end
