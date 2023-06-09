require 'rails_helper'

describe ThankYouMailer, type: :mailer do
  describe 'thank_you' do
    let(:token) { 'abcdefg12345' }
    let(:user) do
      mock_model(User, nickname:             'David',
                       email:                'david@example.com',
                       contributions_count:  24,
                       contribution_token:   token)
    end
    let(:mail) { ThankYouMailer.thank_you(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq '[24 Pull Requests] Thank you for you contributions this xmas'
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq [user.email]
    end

    it 'renders the sender email' do
      expect(email['From'].to_s).to eq '24 Pull Requests <info@pullrequests.com>'
    end

    it 'usees nickname' do
      expect(mail.body.encoded).to match(user.nickname)
    end
  end
end
