require 'rails_helper'

RSpec.describe ApplicationHelper do
  let(:recipe) { create(:recipe) }

  let(:current_user) { create(:user, admin: admin?) }
  let(:admin?) { false }

  before do
    allow(helper).to receive(:current_user).and_return(current_user)
  end

  describe 'can_edit_recipe?' do
    subject { helper.can_edit_recipe?(recipe) }

    context 'when a user is the recipe owner' do
      let(:current_user) { recipe.user }
      it { is_expected.to be true }
    end

    context 'when a user is not a admin or an owner' do
      let(:admin?) { false }
      let(:current_user) { nil }

      it { is_expected.to be false }
    end

    context 'when a user is an admin but not an owner' do
      let(:admin?) { true }

      it { is_expected.to be true }
    end
  end

  describe '#javascript_components' do
    subject { helper.javascript_components('search', 'order_summary') }

    before do
      allow(helper).to receive(:webpack_javascript_path).with('search').
        and_return('/public/assets/search')
      allow(helper).to receive(:webpack_javascript_path).with('order_summary').
        and_return('/public/assets/order_summary')
    end

    it 'creates script tags for the provided components' do
      subject

      expect(helper.content_for(:javascript_components)).to eq(
        "<script src=\"/public/assets/search.js\" defer=\"defer\"></script>\n<script src=\"/public/assets/order_summary.js\" defer=\"defer\"></script>"
      )
    end
  end

  describe '#react_component' do
    subject { helper.react_component(name, data, include_javascript_component) }

    let(:name) { 'order_summary' }
    let(:data) { {} }
    let(:include_javascript_component) { true }

    before do
      allow(helper).to receive(:javascript_components).with(name)
    end

    it { is_expected.to eql('<div class="react-container__order-summary"></div>') }

    it 'includes the javascript component' do
      subject

      expect(helper).to have_received(:javascript_components).once.with(name)
    end

    context 'when passing data' do
      let(:data) { { query: 'order MYB123B' } }

      it { is_expected.to eql('<div class="react-container__order-summary" data-query="order MYB123B"></div>') }
    end

    context 'when include_javascript_component is false' do
      let(:include_javascript_component) { false }

      it 'does not include the javascript component' do
        subject

        expect(helper).to_not have_received(:javascript_components)
      end
    end
  end
end
