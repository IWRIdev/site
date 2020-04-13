require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
}

Shrine.plugin :sequel
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :rack_file

