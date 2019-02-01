module WebpackAssetsHelper
  def webpack_javascript_path(build)
    script = WEBPACK_MANIFEST[build]['js']
    asset_path(['packaged-assets', 'assets', script].join('/'), skip_pipeline: true)
  end

  def webpack_stylesheet_path(build)
    stylesheet = WEBPACK_MANIFEST[build]['css']
    asset_path(['packaged-assets', 'assets', stylesheet].join('/'), skip_pipeline: true)
  end
end
