# frozen_string_literal: true
# == Schema Information
#
# Table name: contacts
#
#  id           :bigint           not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  email        :string           not null
#  address      :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { build_stubbed :contact }

  describe 'relations' do
    it 'has relations' do
      expect(contact).to have_many(:simulations)
    end
  end

  describe 'validations' do
    context 'email validation' do
      let(:contact) { build_stubbed :contact, email: 'wrong email' }

      it 'does not validate' do
        expect(contact).to be_invalid
      end
    end
  end
end
