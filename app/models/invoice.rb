class Invoice < ActiveRecord::Base
  belongs_to :project
  has_one :client, through: :project
  has_many :time_entries
end
