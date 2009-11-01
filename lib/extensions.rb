class Array
  
  def mean_average
    inject(0.0){|sum, value| sum + value } / size
  end
 
  def median
    values = entries.sort
    if size == 1
      values.first
    elsif size.odd?
      values[ (size-1)/2 ]
    else
      ( values[ (size-1)/2 ] + values[ size/2 ] ) / 2.0
    end
  end
  
end

Object.class_eval {def why?; raise "Because it is #{inspect}" ; end}
