module BetterErrors
  module CoreExt
    module Exception
      def set_backtrace(*)
        if caller_locations.none? { |loc| loc.path == __FILE__ }
          @__better_errors_bindings_stack = binding.callers.drop(1)
        end

        super
      end

      def __better_errors_bindings_stack
        @__better_errors_bindings_stack || []
      end
    end
  end
end

Exception.send(:prepend, BetterErrors::CoreExt::Exception)
