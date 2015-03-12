class Invoice < ActiveRecord::Base
  belongs_to :project
  has_one :client, through: :project
  has_one :user, through: :client
  has_many :time_entries

  validates :project_id, presence: true

  def self.with_time_entries
    joins { time_entries.outer }.joins { project.client }
  end

  def number
    id
  end
end
