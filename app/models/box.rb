class Box < ApplicationRecord
  acts_as_tenant :account
  has_many :items, dependent: :destroy
  validates :name, presence: true
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank

  after_initialize -> { 
    self.qr_code = "<img>" if qr_code.nil?
  }

  validate :box_by_plan

  def box_by_plan
    if self.new_record? && account.plan != "unlimited"
      n_boxes = account.boxes.count
      if account.plan == "free" && n_boxes > 0
        errors.add(:base, "Free plans cannot have more than one boxes")
      elsif account.plan == "moderate" && n_boxes > 4
        errors.add(:base, "Moderate plans cannot have more than five boxes")
      end
    end
  end
end
