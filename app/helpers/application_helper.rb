module ApplicationHelper

  def can_edit_recipe?(recipe)
    current_user.present? && (
      recipe.owned_by?(current_user) || current_user.admin?
    )
  end
end
