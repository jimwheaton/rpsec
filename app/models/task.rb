class Task

  attr_accessor :completed_at, :size

  def initialize(options = {})
    mark_completed(options[:completed_at]) if options[:completed_at]
    @size = options[:size]
  end

  def complete?
    @completed_at.present?
  end

  def part_of_velocity?
    complete? && @completed_at >= Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    part_of_velocity? ? size : 0
  end

  def mark_completed(date = nil)
    @completed_at = (date || Time.current)
  end
end