class Session < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_voter
end
