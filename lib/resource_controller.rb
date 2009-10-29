require File.join(File.dirname(__FILE__), "urligence.rb") unless ::Object.const_defined? "Urligence"

begin
  require_dependency 'application_controller'
rescue LoadError => e
  require_dependency 'application'
end


module ResourceController
  ACTIONS           = [:index, :show, :new_action, :create, :edit, :update, :destroy].freeze
  SINGLETON_ACTIONS = (ACTIONS - [:index]).freeze
  FAILABLE_ACTIONS  = ACTIONS - [:index, :new_action, :edit].freeze
  NAME_ACCESSORS    = [:model_name, :route_name, :object_name]

  module ActionControllerExtension
    unloadable

    def resource_controller(*args)
      include ResourceController::Controller

      if args.include?(:singleton)
        include ResourceController::Helpers::SingletonCustomizations
      end
    end
  end
end

#
#"Urligence"
#"ResourceController"
#"Base"
#"Controller "
#"Helpers"
#"Urls"
#"Internal"
#"Nested"
#"CurrentObjects"
#"Action"
#"Accessors"
#"ClassMethods"
#"ActionOptions"
#"ResponseCollector"
#"FailableActionOptions"
#"Singleton"
#"SingletonCustomizations"

require File.join(File.dirname(__FILE__), "resource_controller", "base.rb")

require File.join(File.dirname(__FILE__), "resource_controller", "controller.rb")


require File.join(File.dirname(__FILE__), "resource_controller", "helpers.rb")
#***************************Helpers******************************#
require File.join(File.dirname(__FILE__), "resource_controller", "helpers", "urls.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "helpers", "internal.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "helpers", "nested.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "helpers", "current_objects.rb")
#**************************************************************#
require File.join(File.dirname(__FILE__), "resource_controller", "actions.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "accessors.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "class_methods.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "action_options.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "response_collector.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "failable_action_options.rb")
#*******************************Singleton**********************************#

require File.join(File.dirname(__FILE__), "resource_controller", "singleton.rb")
require File.join(File.dirname(__FILE__), "resource_controller", "helpers", "singleton_customizations.rb")

require File.join(File.dirname(__FILE__), "resource_controller", "routing_ext.rb")

ActionController::Resources.send :include, ResourceController::RoutingExt

require File.dirname(__FILE__)+'/../rails/init.rb' unless ActionController::Base.include?(Urligence)



