# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  title      :string(255)
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  clip       :string(255)
#  detail     :text
#  appeal     :boolean          default(FALSE)
#  link_type  :string(255)      default("daily")
#

# -*- encoding : utf-8 -*-
require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
