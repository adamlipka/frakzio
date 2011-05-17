module Frakzio
  require File.dirname(__FILE__)+'/frakzio/railtie.rb' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def act_as_frakzio(attribute)
      validates attribute, :frakzio => true
      
      #setter
      define_method((attribute.to_s + "=").to_sym) do |value|
        fraction_valid?(attribute, value) ? write_attribute(attribute, frakzionize(value)) : write_attribute(attribute, value)
      end

      #getter
      define_method(attribute) do
        read_attribute(attribute) || ""
      end
      
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    
    def fraction_valid?(attribute, value)
      if value && value.class == String
        if value.match(/\A\d* *\d*\/?\d*\z/).to_s == value || value.match(/\A\d*\.?\d*\z/).to_s == value
          true
        else
          self.errors[attribute] << 'invalid format' unless 
          false
        end
      end
    end
    
    def frakzionize(s = "")
      s = "" unless s
      s = s.to_s
      if s.include?('.')
        logger.info("strating to parse a decimal #{s}")
        frac = fraction_to_s(decimal_to_array(s))
      else if s.include?('/')
        logger.info("strating to parse a graction #{s}")
        frac = fraction_to_s(fraction_to_array(s))
        else
          s == "" ? s = nil : s = s
          frac = s
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

    def fraction_to_s(frac)
      result = ""
      result += frac[0].to_s if frac[0] && frac[0] != 0
      result += " " if frac[0] && frac[0] != 0 && frac[1]
      result += "#{frac[1]}/#{frac[2]}" if frac[1] && frac[2]
      result
    end
  end
end