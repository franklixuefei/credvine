require 'rubygems'
scheduler = Rufus::Scheduler.start_new

scheduler.every("1d") do
   Job.check_ref_pay_date
end