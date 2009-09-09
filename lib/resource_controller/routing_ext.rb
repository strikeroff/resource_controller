module ActionController
  module Resources
    alias_method_chain :map_member_actions, :attribute_support
    private

    def map_member_actions_with_attribute_support(map, resource)
      map_member_actions_without_attribute_support(map, resource)
      name_prefix = (resource.respond_to?(:shallow_name_prefix))?  resource.shallow_name_prefix : resource.name_prefix

      route_path = "#{name_prefix}#{resource.singular}"
      show_attribute_action_options = resource_controller_action_options_for("show_attribute", resource, :get)
      map.send(:"attribute_#{route_path}", "#{resource.member_path}/attribute/:attribute", show_attribute_action_options)
      map.connect("#{resource.member_path}/attribute/:attribute.:format", show_attribute_action_options)

      update_attribute_action_options = resource_controller_action_options_for("update_attribute", resource, :put)
      map.connect("#{resource.member_path}/attribute/:attribute", update_attribute_action_options)
      update_attribute_action_options = resource_controller_action_options_for("update_attributes", resource, :put)
      map.connect("#{resource.member_path}/attributes", update_attribute_action_options)
    end

    def resource_controller_action_options_for(action, resource, method = nil)
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
end
