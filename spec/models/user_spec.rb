require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#display_name' do
    let(:user) { User.create!(name: name, email: email, password: password) }
    let(:name) { 'Michael Hibbs' }
    let(:email) { 'michael.hibbs@honeybee' }
    let(:password) { '123123' }

    it 'returns the name for the user' do
      expect(user.display_name).to eql(name)
    end

    context 'when the user does not have a name' do
      let(:name) { '' }

      it 'returns the email' do
        expect(user.display_name).to eql(email)
      end
    end
  end
end
