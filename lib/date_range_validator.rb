class DateRangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if (!value.nil?)
      if !record.start_date.nil?
        record.errors[attribute] << (options[:message] || "must be later than start date")  if record.start_date > record.end_date
      end
    end
  end
end
