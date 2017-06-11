module ProjectsHelper
  def name_with_status(project)
    content_tag(:span, project.name,
                class: project.on_schedule? ? 'on_schedule' : 'behind_schedule')
  end
end
