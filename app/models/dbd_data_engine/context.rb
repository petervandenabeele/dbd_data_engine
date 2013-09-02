module DbdDataEngine
  class Context
    def self.predicates
      ::DbdOnto::Context.new.
        select do |fact|
          fact.predicate == 'meta:defines_predicate'
        end.
        map do |fact|
          fact.object
        end
    end
  end
end