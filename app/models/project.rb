class Project < ActiveRecord::Base
  belongs_to :client
  [:client_id, :name].each do |field|
    validates field, presence: true
  end
end
