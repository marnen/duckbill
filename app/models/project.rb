class Project < ActiveRecord::Base
  belongs_to :client
  has_many :time_entries
  has_one :user, through: :client

  has_paper_trail on: []

  [:client_id, :name].each do |field|
    validates field, presence: true
  end

  def self.resource_params
    [:client_id, :name]
  end
end
