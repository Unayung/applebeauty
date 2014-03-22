# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  ip         :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_voter
end
