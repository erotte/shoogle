

class Proto

  def add shoes

    unless @similar
      @similar = []
      @similar << shoes
    end
    
    result = {}
    
    shoes.each{|model, size|
      @similar.each{|s|

        if s[model] and s[model] == size

          s.merge! shoes
          result = s
          break
        end
      }
    }
    
    puts "--"+@similar.inspect
    
    result
  end
  
end


p = Proto.new

f1 = {:a => 46, :d => 47, :e => 46}
f2 = {:f => 46, :d => 47, :e => 45}
f3 = {:a => 46, :b => 47, :c => 46}


puts "#{p.add(f1).inspect}, {}"
puts "#{p.add(f2).inspect}, {:a => 46, :e => 46}"
puts "#{p.add(f3).inspect}, {:d => 47, :e => 45.5, :f => 46}"



