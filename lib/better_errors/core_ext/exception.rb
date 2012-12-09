class Exception
  attr_reader :__better_errors_bindings_stack
  
  original_initialize = instance_method(:initialize)
  
  define_method :initialize do |*args|
    unless Thread.current[:__better_errors_exception_lock]
      Thread.current[:__better_errors_exception_lock] = true
      begin
        @__better_errors_bindings_stack = binding.callers.drop(2)
      ensure
        Thread.current[:__better_errors_exception_lock] = false
      end
    end
    original_initialize.bind(self).call(*args)
  end
end