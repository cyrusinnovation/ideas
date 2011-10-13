require_dependency 'current_project'

module DeviseHelper
  include CurrentProject
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.join("<br>")

    html = <<-HTML
<div class="alert-message error fade in" data-alert="alert">
  <a href="#" class="close">x</a>
  #{messages}
</div>
HTML

    html.html_safe
  end
end
