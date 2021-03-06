class Task < ActiveRecord::Base

  belongs_to :project

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    complete? && completed_at >= Project.velocity_length_in_days.days.ago
  end

  def first_in_project?
    return false unless project
    project.tasks.first == self
  end

  def last_in_project?
    return false unless project
    project.tasks.last == self
  end

  def my_place_in_tasks
    project.tasks.index(self)
  end

  def move_up
    swap_order_with(previous_task)
  end

  def move_down
    swap_order_with(next_task)
  end

  def swap_order_with(other)
    other.project_order, self.project_order = self.project_order, other.project_order
    other.save
    self.save
  end

  def next_task
    project.tasks[my_place_in_tasks + 1]
  end

  def previous_task
    project.tasks[my_place_in_tasks - 1]
  end

  def points_toward_velocity
    part_of_velocity? ? size : 0
  end

  def mark_completed(date = nil)
    self.completed_at = (date || Time.current)
  end

  def epic?
    size >= 5
  end

  def small?
    size <= 1
  end
end