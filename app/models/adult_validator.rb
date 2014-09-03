class AdultValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, '：お酒は20歳になってから。') if value > 20.years.ago
  end
end