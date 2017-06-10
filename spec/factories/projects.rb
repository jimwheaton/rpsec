FactoryGirl.define do
  factory :project do  # :project is same name as ActiveRecord class
    name "Project Runway"  #these are method calls, not assignments
    due_date Date.parse("2014-01-12")
  end

  factory :big_project, class: Project do   # :big_project does not correspond to ActiveRecord class so have to explicitly state the class
    name "Big Project"
  end
end