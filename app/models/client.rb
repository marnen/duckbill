class Client < ActiveRecord::Base
  has_many :projects
  belongs_to :user

  has_paper_trail on: []

  validates :state, state: true
  validates :user_id, presence: true

  def self.resource_params
    [:name, :company, :email, :street, :city, :state, :zip]
  end
end
