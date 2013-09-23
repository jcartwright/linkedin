module LinkedIn
  module Api

    module UpdateMethods

      def add_share(share, type='people', id='~')
        path = "/#{type}/#{id}/shares"

        defaults = {:visibility => {:code => "anyone"}}
        post(path, defaults.merge(share).to_json, "Content-Type" => "application/json")
      end

      def join_group(group_id)
        path = "#{person_path}/group-memberships/#{group_id}"
        body = {'membership-state' => {'code' => 'member' }}
        put(path, body.to_json, "Content-Type" => "application/json")
      end

      def add_job_bookmark(bookmark)
        path = "#{person_path}/job-bookmarks"
        body = {'job' => {'id' => bookmark}}
        post(path, body.to_json, "Content-Type" => "application/json")
      end

      def update_comment(network_key, comment)
        path = "#{person_path}/network/updates/key=#{network_key}/update-comments"
        body = {'comment' => comment}
        post(path, body.to_json, "Content-Type" => "application/json")
      end

      def like_share(network_key)
        path = "#{person_path}/network/updates/key=#{network_key}/is-liked"
        put(path, 'true', "Content-Type" => "application/json")
      end

      def unlike_share(network_key)
        path = "#{person_path}/network/updates/key=#{network_key}/is-liked"
        put(path, 'false', "Content-Type" => "application/json")
      end

      def send_message(subject, body, recipient_paths)
        path = "#{person_path}/mailbox"

        message = {
            'subject' => subject,
            'body' => body,
            'recipients' => {
                'values' => recipient_paths.map do |profile_path|
                  { 'person' => { '_path' => "/people/#{profile_path}" } }
                end
            }
        }
        post(path, message.to_json, "Content-Type" => "application/json")
      end

    end

  end
end
