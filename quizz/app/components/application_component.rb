# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  delegate :simple_form_for, to: :helpers
end
