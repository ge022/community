class Event < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validates_presence_of :title, :description

  validate :is_valid_datetime # for validated event start/end time

  def is_valid_datetime
    errors.add(:start_time, 'must be a valid datetime') unless (DateTime.parse(start_time.to_s) rescue false)
    errors.add(:end_time, 'must be a valid datetime') unless (DateTime.parse(end_time.to_s) rescue false)
    errors.add(:start_time, 'must be before the end time') if DateTime.parse(start_time.to_s) > DateTime.parse(end_time.to_s) rescue false
  end

end
