require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:recipes_by_created_at) { [] }

  before do
    allow(Recipe).to receive(:grouped_by_day).
      and_return(recipes_by_created_at)
  end

  describe '#index' do
    it 'assigns recipes grouped by created at' do
      get :index

      expect(assigns[:recipes]).to eql(recipes_by_created_at)
    end
  end
end
