module LinkedIn
  module Api

    module QueryMethods

      def profile(options={})
        path = person_path(options)
        simple_query(path, options)
      end

      def connections(options={})
        path = "#{person_path(options)}/connections"
        simple_query(path, options)
      end

      def network_updates(options={})
        path = "#{person_path(options)}/network/updates"
        simple_query(path, options)
      end

      def company(options = {})
        path   = companies_path(options)
        simple_query(path, options)
      end

      def job(options = {})
        path = jobs_path(options)
        simple_query(path, options)
      end

      def job_bookmarks(options = {})
        path = "#{person_path(options)}/job-bookmarks"
        simple_query(path, options)
      end

      def job_suggestions(options = {})
        path = "#{person_path(options)}/suggestions/job-suggestions"
        simple_query(path, options)
      end

      def group_memberships(options = {})
        path = "#{person_path(options)}/group-memberships"
        simple_query(path, options)
      end

      def shares(options={})
        path = "#{person_path(options)}/network/updates"
        simple_query(path, {:type => "SHAR", :scope => "self"}.merge(options))
      end

      def share_comments(update_key, options={})
        path = "#{person_path(options)}/network/updates/key=#{update_key}/update-comments"
        simple_query(path, options)
      end

      def share_likes(update_key, options={})
        path = "#{person_path(options)}/network/updates/key=#{update_key}/likes"
        simple_query(path, options)
      end

      def is_company_share_enabled?(company_id, options={})
        path = "#{company_pages_path(options.merge(:company_id => company_id))}/relation-to-viewer/is-company-share-enabled"
        boolean_query(path, options)
      end

      def is_company_admin?(company_id, options={})
        path = "#{company_pages_path(options.merge(:company_id => company_id))}/relation-to-viewer/is-company-share-enabled"
        boolean_query(path, options)
      end

      def company_statistics(company_id, options={})
        path = "#{company_pages_path(options.merge(:company_id => company_id))}/company-statistics"
        simple_query(path, options)
      end

      private

        def simple_query(path, options={})
          fields = options.delete(:fields) || LinkedIn.default_profile_fields

          if options.delete(:public)
            path +=":public"
          elsif fields
            path +=":(#{fields.map{ |f| f.to_s.gsub("_","-") }.join(',')})"
          end

          headers = options.delete(:headers) || {}
          params  = to_query(options)
          path   += "?#{params}" if !params.empty?

          Mash.from_json(get(path, headers))
        end

        def boolean_query(path, options={})
          response = get(path, options).to_s.downcase
          response == "true"
        end

    end

  end
end
