module ApplicationHelper
  def flash_class(type)
    case type.to_s
    when 'notice'
      'alert-success'
    when 'alert', 'error'
      'alert-danger'
    when 'warning'
      'alert-warning'
    else
      'alert-info'
    end
  end
end
