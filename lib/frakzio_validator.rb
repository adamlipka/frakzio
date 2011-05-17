class FrakzioValidator < ActiveModel::EachValidator
  # implement the method called during validation
  def validate_each(record, attribute, value)
    if value 
      record.errors[attribute] << 'invalid format' unless value.match(/\A\d* *\d*\/?\d*\z/).to_s == value || value.match(/\A\d*\.?\d*\z/).to_s == value
    end
  end
end