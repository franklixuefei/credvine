class Job < ActiveRecord::Base
  
  def self.check_ref_pay_date
    Smb.all.each do |smb|
      if smb.credit != "free"
        if smb.campaign_activated?
          codes_without_pay = smb.codes.where(:paid => nil)
          succ_codes_without_pay = codes_without_pay.where(:frien_status => "REDEEMED")
          smb.num_of_codes_to_pay = codes_without_pay.count #check daily to update how many codes should be paid
          smb.num_of_succ_codes_to_pay = succ_codes_without_pay.count
          smb.save!
          if Date.today - smb.date_of_payment_for_ref >= 7
            smb.charge_ref_payment(codes_without_pay)
          end
        # else
          # puts "NOT ACTIVATED"
        end
      else
        smb.codes.each do |code|
          code.paid = true
          code.save(:validate => false)
        end
      end
    end
  end
  
end
