# == Schema Information
#
# Table name: nacebel_codes
#
#  id          :bigint           not null, primary key
#  identifier  :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class NacebelCode < ApplicationRecord
  validates :identifier, presence: true
  validates :identifier, format: { with: /\d{5}/,
                                          message: 'Nacebell number always have 5 digits'
                                        }
end
