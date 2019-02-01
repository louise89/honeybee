require 'rails_helper'

RSpec.describe Mealplan, type: :model do
  let(:user) { create(:user) }
  let(:mealplan) { create(:mealplan, user: user) }

  describe 'owned_by?' do
    subject { mealplan.owned_by?(other_user) }

    let(:other_user) { user }

    it { is_expected.to be true }

    context 'when a user is not the mealplan owner' do
      let(:other_user) { nil }

      it { is_expected.to be false }
    end
  end
end
