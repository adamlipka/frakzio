class FrakzioValidator < ActiveModel::EachValidator
  # implement the method called during validation
  def validate_each(record, attribute, value)
    if value 
      record.errors[attribute] << 'invalid format' unless value.match(/^\d* *\d*\/?\d*$/) == value || value.match(/^\d*\.\d+$/) == value
    end
  end
end