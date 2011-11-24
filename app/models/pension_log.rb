class PensionLog < ActiveRecord::Base
  belongs_to :area
  belongs_to :sub_area
  belongs_to :pension
end
