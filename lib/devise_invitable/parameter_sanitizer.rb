module DeviseInvitable
  module ParameterSanitizer
    def invite
      default_params.permit self.for(:invite)
    end

    def accept_invitation
      default_params.permit self.for(:accept_invitation)
    end

    def self.included(base)
      base.alias_method_chain :attributes_for, :invitable
    end

    private
    def attributes_for_with_invitable(kind)
      case kind
      when :invite
        resource_class.invite_key_fields
      when :accept_invitation
        [:password, :password_confirmation, :invitation_token]
      else attributes_for_without_invitable(kind)
      end
    end
  end
end
