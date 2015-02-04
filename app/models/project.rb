class Project < ActiveRecord::Base
  belongs_to :client
  has_many :time_entries
  has_one :user, through: :client

  [:client_id, :name].each do |field|
    validates field, presence: true
  end
end
