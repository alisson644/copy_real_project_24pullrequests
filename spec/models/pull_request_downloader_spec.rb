require 'rails_helper'

describe PullrequestDownloader, type: :model do
  let(:pull_request_downloader) { described_class.new 'foobar', 'Aet8Boux' }

  describe '.pull_request' do
    let(:event) do
      double('event').tap do |event|
        allow(event).to receive(:type).and_return('PullRequestEvent')
        allow(event).to receive_message_chain(:payload, :action).and_return('opened')
        allow(event).to receive(:[]).with('created_at').and_return("24/12/#{PullrequestsCopy::application.current_year}")
      end
    end

    before do
      expect_any_instance_of(Octokit::Client).to receive(:user_events).and_return([event])
    end

    subject { pull_request_dowloader.pull_requests }
    it { is_expected.to eq [event] }
  end
end
