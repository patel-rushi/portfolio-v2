class UploadsController < ApplicationController
  before_action :authenticate

  UPLOAD_DIR = Rails.root.join("public", "images", "editor")
  MAX_FILE_SIZE = 50.megabytes
  ALLOWED_CONTENT_TYPES = %w[image/jpeg image/png image/gif image/webp image/svg+xml image/heic image/heif].freeze

  def create
    file = params[:file]

    unless file.is_a?(ActionDispatch::Http::UploadedFile)
      return render json: { error: "No file provided" }, status: :unprocessable_entity
    end

    unless file.size <= MAX_FILE_SIZE
      return render json: { error: "File too large (max #{MAX_FILE_SIZE / 1.megabyte}MB)" }, status: :unprocessable_entity
    end

    unless ALLOWED_CONTENT_TYPES.include?(file.content_type)
      return render json: { error: "Unsupported file type" }, status: :unprocessable_entity
    end

    FileUtils.mkdir_p(UPLOAD_DIR) unless Dir.exist?(UPLOAD_DIR)

    filename = "#{SecureRandom.hex(8)}_#{file.original_filename.parameterize(preserve_case: true)}"
    filepath = UPLOAD_DIR.join(filename)

    File.open(filepath, "wb") { |f| f.write(file.read) }

    render json: { url: "/images/editor/#{filename}" }
  end
end
