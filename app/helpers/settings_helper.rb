module SettingsHelper
  def buckets_csv project
    project.buckets.collect { |bucket| bucket.pretty_print }.join ", "
  end

  def div_class project, field
    div_class = "clearfix"
    div_class += ' error' if project.errors.messages.key? field
    div_class
  end

  def inline_help project, field
    project.errors.messages[field].join(', ') if project.errors.messages.key? field
  end
end
