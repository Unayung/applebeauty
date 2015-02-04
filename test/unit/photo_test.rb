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

# -*- encoding : utf-8 -*-
require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
