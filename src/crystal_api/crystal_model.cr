macro crystal_model(name, *properties)
  struct {{name.id}}
    {% for property in properties %}
      getter {{property.var}} : {{property.type}}
    {% end %}

    JSON.mapping(
    {% for property in properties %}
      {{property.var}}: {{property.type}},
    {% end %}
    )

    def initialize({{
                     *properties.map do |field|
                       "@#{field.id}".id
                     end
                   }})
    end

    def initialize(h : Hash)
      {% for property in properties %}
        if h["{{property.var}}"]?
          if h["{{property.var}}"].as?( ({{property.type}}) )
            self.{{property.var}} = h["{{property.var}}"].as( ({{property.type}}) )
          end
        end
      {% end %}
    end

    def initialize(keys : Array, values : Array)
      {% for property in properties %}
        keys.each_index do |i|
          if keys[i] == "{{property.var}}"

            if values[i].as?( ({{property.type}}) )
              self.{{property.var}} = values[i].as( ({{property.type}}) )
            end

          end
        end
      {% end %}
    end

    {{yield}}

    def clone
      {{name.id}}.new({{
                        *properties.map do |property|
                          if property.is_a?(Assign)
                            "@#{property.target.id}.clone".id
                          elsif property.is_a?(TypeDeclaration)
                            "@#{property.var.id}.clone".id
                          else
                            "@#{property.id}.clone".id
                          end
                        end
                      }})
    end

  end
end
