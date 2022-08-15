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
class Contact < ApplicationRecord
  has_many :simulations, dependent: :destroy

  validates :first_name, :last_name, :email,
            :address, :phone_number, presence: true
end
