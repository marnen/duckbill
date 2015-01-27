class TimeEntry < ActiveRecord::Base
  belongs_to :user
  [:user_id, :date, :hours, :description].each {|field| validates field, presence: true }

  def self.resource_params
    [:date, :hours, :description, :notes]
  end
end