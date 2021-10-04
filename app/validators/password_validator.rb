class PasswordValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value =~ /\d/ || value =~ /[.@.$.&.#.!]/
      record.errors[attribute] << (options[:message] || 'Must contain atleast one number or symbol')
    end
  end
end
