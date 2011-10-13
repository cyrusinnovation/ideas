class SettingsController < SecureController
  def edit
    @buckets_csv = current_project.buckets.collect { |bucket| bucket.pretty_print }.join ", "
  end

  def update
    update_project
    change_buckets
    redirect_to project_edit_settings_path
  end

  private

  def update_project
    project = current_project
    project.name = params[:name]
    project.target_point_size = params[:target_point_size]
    project.save
  end

  def change_buckets
    buckets = buckets_from_strings(clean_buckets(params[:buckets]))
    current_project.buckets = buckets
  end

  def buckets_from_strings bucket_strings
    bucket_strings.collect do |bucket_string|
      bucket_string.strip!

      bucket = current_project.buckets.find_by_value bucket_string
      bucket = Bucket.create(:value => bucket_string) if bucket.nil?
      bucket
    end
  end

  def clean_buckets bucket_strings
    buckets = bucket_strings.split ","
    buckets.select do |bucket| 
      bucket.strip!
      bucket =~ /^[0-9.]+$/
    end
  end
end
