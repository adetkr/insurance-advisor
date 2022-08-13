# == Schema Information
#
# Table name: simulations
#
#  id                 :bigint           not null, primary key
#  contact_id         :bigint           not null
#  annual_revenue     :integer
#  enterprise_number  :string
#  company_legal_name :string
#  natural_person     :boolean          default(FALSE)
#  nacebel_codes      :text             default([]), is an Array
#  quote              :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Simulation < ApplicationRecord
  belongs_to :contact

  validates :annual_revenue, :company_legal_name, :natural_person,
            :nacebel_codes, :enterprise_number, presence: true
  validates :enterprise_number, format: { with: /0\d{9}/,
                                          message: 'Enterprise number always start with 0 and is exactly 10 digits'
                                        }
  validate :nacebel_codes_format

  private

  def nacebel_codes_format
    return if nacebel_codes&.all? { |nacebel_code| nacebel_code.match?(/\d{5}/) }

    errors.add(:nacebel_codes, 'Nacebel codes should be 5 digits')
  end
end
