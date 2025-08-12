class ProductLabel < ApplicationRecord
  enum :baseline_type, [ :grams, :liters ]

  validates_presence_of :energy, :fats, :saturated_fats, :carbohydrates, :sugar_carbohydrates,
    :protein, :salt, :vitamins, :ingredients, :baseline, :baseline_type, :name, :weight,
    :volume

  after_initialize :set_defaults

  def set_defaults
    self.energy ||= 0
    self.fats ||= 0
    self.saturated_fats ||= 0
    self.carbohydrates ||= 0
    self.sugar_carbohydrates ||= 0
    self.protein ||= 0
    self.salt ||= 0

    if self.baseline.present? && self.baseline_type.present?
      case self.baseline_type.to_sym
      when :grams
        self.weight ||= self.baseline
      when :liters
        self.volume ||= self.baseline * 1000
      end
    end

    self.weight ||= 0
    self.volume ||= 0
    self.vitamins ||= "None"
    self.ingredients ||= "N/A"
  end
end
