module Dagon
  module Core
    class DG_String < DG_Object
      def initialize value
        @value = value
        @klass = DG_String_Class.new
      end

      def to_s
        @value
      end

      def inspect
        @value
      end
    end

    class DG_String_Class < DG_Class
      def initialize value = ""
        super("String", Dagon::Core::DG_Class.new)
        @class_methods[:new] = ->(vm, ref, *args) {
          obj = DG_String.new(*args)
          obj
        }
        boot
      end

      def boot
        add_method "init", ->(vm, ref, value) {
          ref.instance_variable_set("@value", value)
        }
        add_method "+", ->(vm, ref, other) {
          left = ref.instance_variable_get("@value")
          right = other.instance_variable_get("@value")
          ref.klass.dagon_send(vm, :new, left + right)
        }
      end
    end
  end
end