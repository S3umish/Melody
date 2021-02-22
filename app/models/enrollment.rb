class Enrollment < ApplicationRecord
    belongs_to :instrument
    belongs_to :user


    validates :instrument, :level, :duration, presence: true

    validates :price, numericality: {greater_than: 0, message:  "should be $39, $49, $89 only !!"}
    validates :student, presence: true, uniqueness: { case_sensitive: false }

    scope :order_by_date, -> { order(created_at: :asc) }

    accepts_nested_attributes_for :instrument, :reject_if=> all_blank, :allow_destroy =>true


    def instrument_attributes=(instrument_attributes)
        self.instrument = Instrument.find_or_create_by(name: attr[:name])
    end

    def self.find_by_instrument_id(id)
        where(instrument: id)
    end

    def display_date
        self.startdate.strftime("%A, %b %d") if self.startdate
    end

end
