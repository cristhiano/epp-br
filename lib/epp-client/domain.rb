module EPP
  module Domain

    NAMESPACE       = 'urn:ietf:params:xml:ns:brdomain-1.0'
    SCHEMA_LOCATION = 'urn:ietf:params:xml:ns:brdomain-1.0 brdomain-1.0.xsd'

    class Command
      def brorg_to_xml(brorg)
        domain_node('organization', "\n#{brorg}\n")
      end

      def to_xml
        @namespaces ||= {}
        # @namespaces[:domain] = xml_namespace(node, 'brdomain', NAMESPACE)
        node = domain_node(name)

        xattr = XML::Attr.new(node, "schemaLocation", SCHEMA_LOCATION)
        xattr.namespaces.namespace = @namespaces['xsi'] || XML::Namespace.new(node, 'xsi', 'http://www.w3.org/2001/XMLSchema-instance')
        puts node
        node
      end



      # def domain_namespace(node)
      #   return @namespaces['domain'] if @namespaces.has_key?('domain')
      #   @namespaces['brdomain'] = xml_namespace(node, 'brdomain', NAMESPACE)
      # end
      # public :domain_namespace
    end

    class Create < Command
      def initialize(name, options = {})
        @name = name
        @period = options.delete(:period) || '1y'
        @nameservers = Array(options.delete(:nameservers))
        @registrant = options.delete(:registrant)
        @contacts = options.delete(:contacts)
        @auth_info = options.delete(:auth_info)
        @brorg = options.delete(:brorg)

        @period_val, @period_unit = validate_period(@period)
      end

      def to_xml
        node = super
        node << domain_node('name', @name)

        if @period_val && @period_unit
          p = domain_node('period', @period_val)
          p['unit'] = @period_unit

          node << p
        end

        unless @nameservers.empty?
          node << nameservers_to_xml(@nameservers)
        end

        node << domain_node('registrant', @registrant) if @registrant

        contacts_to_xml(node, @contacts)

        node << auth_info_to_xml(@auth_info) unless @auth_info.empty?

        node << brorg_to_xml(@brorg)

        node
      end
    end
  end
end
