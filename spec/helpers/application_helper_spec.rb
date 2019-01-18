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
end
