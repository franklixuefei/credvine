class PromoCode < ActiveRecord::Base
  belongs_to :smb
  belongs_to :signup_request
  
  def self.generate_promocode
    begin
      promocode = SecureRandom.base64(9).delete("=").delete("\n\r").tr("+/", "-_")
    end while PromoCode.exists?(:promo_code => promocode)
    return promocode
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.base64.delete("=").delete("\n\r").tr("+/", "-_")
    end while Smb.exists?(column => self[column])
  end
end
