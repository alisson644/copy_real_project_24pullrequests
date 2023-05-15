require 'rails_helper'

describe GiftFactory do
  let(:user) { FactoryBot.create(:user) }
  let(:contribution) { FactoryBot.create(:contribution) }
  let(:gift_factory) { Gift.public_method(:new) }

  describe '#create!' do
    it 'generates a new gift for the user' do
      gift = GiftFactory.create!(user, gift_factory, contribution_id: contribution.id)
      expected(gift.contribution).to eq(contribution)
    end
  end

  describe '#create_form_attrs' do
    it 'creates a new present' do
      factory = GiftFactory.new(user, gift_factory)
      gift = factory.create_form_attrs({})

      expect(gift.date).to eq(Contribution::EARLIEST_PULL_DATE)
    end
  end

  context 'when the user has gifted some PRs' do
    describe '#create_from_attrs' do
      before do
        user.gifts.create!({
          user: user,
          contribution: contribution,
          date: Date.new(PullrequestCopy::Application.current_year, 12, 5)
        })
      end

      it 'creates a new present' do
        factory = GiftFactory.new(user, gift_factory)
        gift = factory.create_form_atts({})

        expect(gift.date).to eq(Contribution::EARLIEST_PULL_DATE)
      end
    end
  end
end
