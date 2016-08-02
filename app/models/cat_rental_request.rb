# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  STATUS = %w(DENIED APPROVED PENDING)

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUS, message: 'Please pick a valid status' }
  validate :overlapping_approved_requests

  belongs_to :cat

  def overlaps?(other)
    return true if self.start_date >= other.start_date && self.start_date <= other.end_date
    return true if self.end_date <= other.end_date && self.end_date >= other.start_date
    return true if self.start_date <= other.start_date && self.end_date >= other.end_date
    return false
  end

  def overlapping_approved_requests
    all_approved_requests = CatRentalRequest.where("cat_id = ? AND status = ?", self.cat_id, "APPROVED")
    all_approved_requests.each do |request|
      if self.overlaps?(request)
        self.errors[:overlap] << "This is an overlapping request"
      end
    end
  end

end
