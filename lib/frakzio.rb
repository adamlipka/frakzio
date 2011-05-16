module Frakzio
  require File.dirname(__FILE__)+'/frakzio/railtie.rb' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def act_as_frakzio(options = {})
      options.each do |option|
        validates option, :frakzio => true
      
        define_method((option.to_s + "=").to_sym) do |value|
          write_attribute(option, frakzionize(value))
        end

        
      end
    end
  end
  
  def frakzionize(s = "")
    s = "" unless s
    s = s.to_s
    if s.include?('.')
      frac = decimal_to_array(s)
    else if s.include?('/')
        frac = fraction_to_array(s)
      else
        s == "" ? s = nil : s = s.to_i
        frac = [s, nil, nil]
      end
    end
    frac
  end

  def nwd(a,b)
    while b!=0 do
      a,b = b,a%b
    end

    return a
  end
  
  def simplify(array)
    index = array.size - 2
    entires = index == 0 ? 0 : array[index-1] ? array[index-1] : 0
        
    rest        = array[index]%array[index+1]
    entires     += array[index]/array[index+1]
    n           = nwd(rest, array[index+1])
    numerator   = rest/n
    denominator = array[index+1]/n

    numerator = denominator = nil if numerator == 0

    [entires, numerator, denominator]
  end    

  def decimal_to_array(d)
    precision   = 10**6
    numerator   = (d.to_f*precision).to_i
    
    simplify([numerator, precision])
  end

  def fraction_to_array(d)
    result = []
    if d.include?(" ")
      result << d.split(" ").first.to_i
      result.concat get_fraction(d.split(" ").last)
    else
      result << nil
      result.concat get_fraction(d)
    end

    simplify(result)
  end

  def get_fraction(s)
    s.split("/").map {|x| x.to_i}
  end

  def to_s(frac)
    result = ""
    result += frac[0].to_s if frac[0] && frac[0] != 0
    result += " " if frac[0] && frac[0] != 0 && frac[1]
    result += "#{frac[1]}/#{frac[2]}" if frac[1] && frac[2]
    result
  end
end