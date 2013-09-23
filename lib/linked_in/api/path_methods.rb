module LinkedIn
  module Api

    module PathMethods

      private

        def person_path(options={})
          path = "/people/"

          if id = options.delete(:id)
            path += "id=#{id}"
          elsif url = options.delete(:url)
            path += "url=#{CGI.escape(url)}"
          else
            path += "~"
          end
        end

        def companies_path(options={})
          path = "/companies"

          if domain = options.delete(:domain)
            path += "?email-domain=#{CGI.escape(domain)}"
          elsif id = options.delete(:id)
            path += "/id=#{id}"
          elsif url = options.delete(:url)
            path += "/url=#{CGI.escape(url)}"
          elsif name = options.delete(:name)
            path += "/universal-name=#{CGI.escape(name)}"
          elsif admin = options.delete(:is_company_admin)
            path += "?is-company-admin=true"
          else
            path += "/~"
          end
        end

        def company_pages_path(options={})
          path = "/companies"

          if id = options.delete(:id)
            path += "/#{id}"
          elsif company_id = options.delete(:company_id)
            path += "/#{company_id}"
          end
        end

        def jobs_path(options={})
          path = "/jobs"

          if id = options.delete(:id)
            path += "/id=#{id}"
          else
            path += "/~"
          end
        end

    end


  end
end