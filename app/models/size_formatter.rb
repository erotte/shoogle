class SizeFormatter
  include ActionView::Helpers::NumberHelper
  @@separator = '.'
  #I18n.translate(:'number.format')[:separator]
  attr_reader :value_string, :integer, :fraction

  def initialize value
    @value_string = value.to_s
    @integer = extract_int
    @fraction = extract_fraction
  end

  def to_s
    strip_insignificant_zeros(formatted_number(to_f)) rescue nil
  end

  def to_f
    (@integer + @fraction).to_f  rescue nil
  end

  def to_i
    @integer.to_i
  end

  def extract_int
    val = nil
    if got_fraction_string?
      val = @value_string.gsub(/\s*\d\/\d/, '')
    else
      val = formatted_number(@value_string)
    end
    val.blank? ? nil : val.to_s.gsub(',', '.').to_i
  end

  def strip_insignificant_zeros number
    escaped_separator = Regexp.escape(@@separator)
    number.sub(/(#{escaped_separator})(\d*[1-9])?0+\z/, '\1\2').sub(/#{escaped_separator}\z/, '').html_safe
  end

  def extract_fraction
    fraction = nil
    if got_fraction_string?
      fract_part = @value_string[/\d\/\d/]
      fraction = fract_part.split('/').inject { |a, b| a.to_f / b.to_f }
    else
      fraction = @value_string.gsub(',', '.').to_f % 1.0
    end
    fraction
  end

  def got_fraction_string?
    /\s*\d\/\d/ === @value_string
  end

  def formatted_number number
    number_with_precision(number, :precision => 2, :separator => @@separator)
  end

end
