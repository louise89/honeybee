manifest_path = Rails.root.join('tmp', 'webpack-manifest.json')

if File.exist? manifest_path
  WEBPACK_MANIFEST = JSON.parse(File.read(manifest_path))
end
