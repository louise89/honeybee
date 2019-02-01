require 'rails_helper'

RSpec.describe WebpackAssetsHelper do
  before do
    stub_const('WEBPACK_MANIFEST', {
      'main' => {
        'js' => 'script.46652752552d6325e5f5.js',
        'css' => 'styles.d41d8cd98f00b204e9800998ecf8427e.css'
      }
    })
  end

  describe '#webpack_javascript_path' do
    it 'returns the location of the script' do
      expect(helper.webpack_javascript_path('main')).to eql(
        '/packaged-assets/assets/script.46652752552d6325e5f5.js'
      )
    end

    describe 'invalid bundle' do
      it 'throws an exception' do
        expect{ helper.webpack_javascript_path('invalid_bundle') }.to raise_error(NoMethodError)
      end
    end
  end

  describe '#webpack_stylesheet_path' do
    it 'returns the location of the stylesheet' do
      expect(helper.webpack_stylesheet_path('main')).to eql(
        '/packaged-assets/assets/styles.d41d8cd98f00b204e9800998ecf8427e.css'
      )
    end

    describe 'invalid bundle' do
      it 'throws an exception' do
        expect{ helper.webpack_stylesheet_path('invalid_bundle') }.to raise_error(NoMethodError)
      end
    end
  end
end
