module Frakzio
  
  require 'frakzio'
  require 'rails'
  require 'frakzio_validator'
  
  class Railtie < Rails::Railtie
    
    initializer 'frakzio.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Frakzio
      end
    end
  end
end
