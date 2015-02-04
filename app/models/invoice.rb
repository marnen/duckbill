class Invoice < ActiveRecord::Base
  belongs_to :project
  has_many :time_entries
end
