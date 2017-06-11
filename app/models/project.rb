class Project < ActiveRecord::Base

  has_many :tasks

  validates :name, presence: true

  def self.velocity_length_in_days
    21
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.to_a.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def completed_velocity
    tasks.to_a.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0 / Project.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    projected_days_valid? && (Date.today + projected_days_remaining) <= due_date
  end

  def projected_days_valid?
    return !(projected_days_remaining.nan? || projected_days_remaining == Float::INFINITY)
  end
end