class AddPullRequestCounterCacheColumsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :pull_request_count, :integer, default: 0

    User.reset_column_information
    User.all.each do |p|
      User.update_counters p.id, pull_requests_count: p.pull_requests.count
    end
  end
end
