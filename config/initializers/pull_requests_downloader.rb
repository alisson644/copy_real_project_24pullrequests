Rails.application.config.pull_request.downloader = if Rails.env.production? || !ENV['GITHUB_KEY'].blank?
                                                    ->(login, oauth_token) { PullRequestDownloader.new(login, oauth_token) }
                                                   else
                                                    ->(_login, _oauth_token) { Struct.new(:pull_requests, :user_organisations).new([],[]) }
                                                   end