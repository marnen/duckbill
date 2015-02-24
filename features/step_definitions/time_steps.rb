Given /^the time is frozen at (.+) in zone "(.*?)"$/ do |time, zone|
  Timecop.freeze ActiveSupport::TimeZone[zone].parse time
end