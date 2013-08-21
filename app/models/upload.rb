class Upload < ActiveRecord::Base
	attr_accessible :upload,:product_id
  has_attached_file :upload

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "id" => read_attribute(:id),
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE"
    }
  end

  def get_file_url
    self.upload.url.split("/")[0..-2].join("/") << "/#{self.upload_file_name}"
  end
end
