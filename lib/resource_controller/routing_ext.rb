#module ActionController
#  module Resources


module ResourceController
  module RoutingExt
    def self.included(base)
      base.alias_method_chain :map_member_actions, :attribute_support

      base.send :define_method, :resource_controller_action_options_for do |action, resource, method|
        default_options = { :action => action.to_s }
        case default_options[:action]
          when "show_attribute";                            
            default_options.merge(add_conditions_for(resource.conditions, method || :get)).merge(resource.requirements(true)).merge({ :attribute =>  /[A-Za-z_]+/  })       # old cool but hard/([A-Za-z]+[_]?)+(?=[-])/
          when "update_attribute";
            default_options.merge(add_conditions_for(resource.conditions, method || :put)).merge(resource.requirements(true)).merge({ :attribute =>   /[A-Za-z_]+/})
          when "update_attributes";
            default_options.merge(add_conditions_for(resource.conditions, method || :put)).merge(resource.requirements(true))
          else
            default_options.merge(add_conditions_for(resource.conditions, method)).merge(resource.requirements)
        end
      end
    end
    private

    #def resource_controller_action_options_for(action, resource, method = nil)
    #
    #end

    def map_member_actions_with_attribute_support(map, resource)
      map_member_actions_without_attribute_support(map, resource)
      route_path = "#{resource.shallow_name_prefix}#{resource.singular}"
      #
      show_attribute_action_options = resource_controller_action_options_for("show_attribute", resource, :get)
      #
      map.send(:"attribute_#{route_path}", "#{resource.member_path}/attribute/:attribute", show_attribute_action_options)
      map.connect("#{resource.member_path}/attribute/:attribute.:format", show_attribute_action_options)

      update_attribute_action_options = resource_controller_action_options_for("update_attribute", resource, :put)
      map.connect("#{resource.member_path}/attribute/:attribute", update_attribute_action_options)
      update_attribute_action_options = resource_controller_action_options_for("update_attributes", resource, :put)
      map.connect("#{resource.member_path}/attributes", update_attribute_action_options)
    end


  end
end

#
#
#["show_attribute",
# <ActionController::Resources::Resource:0x4a51820
#@nesting_path_prefix="/press_posts/:press_post_id",
#         @member_methods={:get=>[:edit]},
#         @conditions={},
#         @shallow_path_prefix=nil,
#         @name_prefix=nil,
#         @path_segment=:press_posts,
#         @plural=:press_posts,
#         @controller="press_posts",
#         @requirements={},
#         @path="/press_posts",
#         @path_prefix=nil,
#         @singular="press_post",
#         @id_requirement={:id=>/[^\/.?]+/},
#         @shallow_name_prefix=nil,
#         @new_methods={:get=>[:new]},
#         @member_path="/press_posts/:id",
#         @collection_methods={},
#         @action_separator="/",
#         @new_path="/press_posts/new",
#         @options={}, @allowed_actions={}>,
#         :get]


#  end
#end




#module ActionController
#  module Resources
#    alias_method :old_map_member_actions, :map_member_actions
#    private
#
#    def map_member_actions(map, resource)
#      old_map_member_actions(map, resource)
#      route_path = "#{resource.shallow_name_prefix}#{resource.singular}"
#      show_attribute_action_options = resource_controller_action_options_for("show_attribute", resource, :get)
#      map.send(:"attribute_#{route_path}","#{resource.member_path}/attribute/:attribute", show_attribute_action_options)
#      map.connect("#{resource.member_path}/attribute/:attribute.:format", show_attribute_action_options)
#
#      update_attribute_action_options = resource_controller_action_options_for("update_attribute", resource, :put)
#      map.connect("#{resource.member_path}/attribute/:attribute", update_attribute_action_options)
#      update_attribute_action_options = resource_controller_action_options_for("update_attributes", resource, :put)
#      map.connect("#{resource.member_path}/attributes", update_attribute_action_options)
#    end
#
#    def resource_controller_action_options_for(action, resource, method = nil)
#      default_options = { :action => action.to_s }
#      case default_options[:action]
#      when "show_attribute";
#        default_options.merge(add_conditions_for(resource.conditions, method || :get)).merge(resource.requirements(true)).merge({ :attribute =>  /[A-Za-z_]+/  })       # old cool but hard/([A-Za-z]+[_]?)+(?=[-])/
#      when "update_attribute";
#        default_options.merge(add_conditions_for(resource.conditions, method || :put)).merge(resource.requirements(true)).merge({ :attribute =>   /[A-Za-z_]+/})
#      when "update_attributes";
#        default_options.merge(add_conditions_for(resource.conditions, method || :put)).merge(resource.requirements(true))
#      else
#        default_options.merge(add_conditions_for(resource.conditions, method)).merge(resource.requirements)
#      end
#    end
#  end
#end
