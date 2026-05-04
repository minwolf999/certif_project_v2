# frozen_string_literal: true

module Common
  module Arrow
    class Component < ApplicationComponent
      def initialize(kind:)
        @kind = kind
      end

      def classes
        case @kind
        when :up
          'rotate-[270deg]'
        when :down
          'rotate-[90deg]'
        when :left
          'rotate-[180deg]'
        end
      end
    end
  end
end
