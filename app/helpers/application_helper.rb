module ApplicationHelper

  def can_edit?(resource)
    current_user.present? && (
      resource.owned_by?(current_user) || current_user.admin?
    )
  end

  def javascript_components(*components)
    content_for :javascript_components do
      javascript_include_tag *javascript_component_paths(components), defer: true
    end
  end

  def react_component(name, data = {}, include_javascript_component = true)
    if include_javascript_component
      javascript_components name
    end

    content_tag(
      :div,
      nil,
      class: "react-container__#{name.titleize.parameterize}",
      data: data
    )
  end

  private

  def javascript_component_paths(components)
    components.map { |component| webpack_javascript_path(component) }
  end
end
