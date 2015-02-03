class Client < ActiveRecord::Base
  has_many :projects
  belongs_to :user

  validates :user_id, presence: true
end
