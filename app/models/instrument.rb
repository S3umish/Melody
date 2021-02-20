class Instrument < ApplicationRecord
    has_many :enrollments, dependent: :destroy
    has_many :users, through: :enrollments
    validates :name, presence: true, uniqueness: true
    
    accepts_nested_attributes_for :enrollments,reject_if: proc {|attr| attr['level'].blank? || attr['price'].blank?|| attr['duration'].blank?}
    
    scope :alphabetize, -> { order(name: :asc) }

end