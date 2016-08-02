# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, presence: true
  validates :sex, length: { in: 0..1 }, inclusion: { in: ["M", "F"],
    message: "Please pick either M or F" }
  validates :color, inclusion: { in: ["Brown", "Black", "White", "Spotted"],
    message: "Please pick a valid color" }

  CAT_COLORS = ["Brown", "Black", "White", "Spotted"]

  def age
    now = Time.now.utc.to_date
    bday = self.birth_date
    now.year - bday.year - ((now.month > bday.month ||
    (now.month == bday.month && now.day >= bday.day)) ? 0 : 1)
  end




end