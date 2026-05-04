# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :read, Quiz
    can :read, Question

    can :manage, Quiz, user_id: user.id
    can :manage, Question, quiz: { user_id: user.id }
    can :manage, Score, user_id: user.id
  end
end
