class AdultValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, '未成年の方は登録することができません') if value.present? && value > 20.years.ago
  end
end