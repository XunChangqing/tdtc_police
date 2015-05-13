class Ability
  include CanCan::Ability

  def initialize(cuser)
    # Define abilities for the passed in user here. For example:
    #
    cuser ||= User.new # guest user (not logged in)
    if cuser.is? "user.user_admin" and cuser.orgnization == User::ORGS[0]
      can :manage, User
      can :manage, PasswordResetRequest
      can :manage, AuthorityChangeRequest
      can :manage, UserLog
    end

    if cuser.is? "user.user_admin" and cuser.orgnization != User::ORGS[0]
      can :manage, User, orgnization: cuser.orgnization
      can :manage, PasswordResetRequest, :user => {orgnization: cuser.orgnization}
      can :manage, AuthorityChangeRequest, :user => {orgnization: cuser.orgnization}
      can :manage, UserLog, :user => {orgnization: cuser.orgnization}
    end

    if cuser.id
      can :create, AuthorityChangeRequest
      can :delete, AuthorityChangeRequest
    end

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
