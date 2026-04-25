# frozen_string_literal: true

module Common
  module Button
    class Component < ApplicationComponent
      def initialize(focus: false, **options)
        @focus = focus
        @options = options
      end

      def classes
        common_classes = 'rounded-full py-2 px-4 cursor-pointer '

        kind_classes = if @focus
                         'bg-primary text-f5f5f5 shadow-primary '
                       else
                         'bg-white text-333333 border-solid border-2 border-e0e0e0 hover:shadow-primary hover:border-primary '
                       end

        common_classes + kind_classes + @options[:class].to_s
      end
    end
  end
end
