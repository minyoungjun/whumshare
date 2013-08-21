class Upload < ActiveRecord::Base
	attr_accessible :upload,:product_id
  has_attached_file :upload
	belongs_to :product

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
	def self.get_files_url(uploads)
		files_url=Array.new
		uploads.each do |upload|
			files_url.push(upload.get_file_url)
		end
		return files_url
  end

end
