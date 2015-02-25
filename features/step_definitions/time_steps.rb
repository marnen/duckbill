Given /^the time is frozen at (.+)(?: in zone "(.*?)")?$/ do |time, zone|
  zone ||= @current_user.try(:time_zone) || 'UTC'
  Timecop.freeze ActiveSupport::TimeZone[zone].parse time
end