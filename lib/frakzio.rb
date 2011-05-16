module Frakzio
  require File.dirname(__FILE__)+'/frakzio/railtie.rb' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def act_as_frakzio(options = {})
      unless redeemable?
        puts options
      end
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    
  end
end