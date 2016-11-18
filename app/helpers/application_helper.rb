module ApplicationHelper
  def error_class(resource, field)
    resource.errors[field].any? ? 'has-error' : ''
  end
end
