require 'rails_helper'

describe PopularityScorer do
  let(:nickname) { 'nickname' }
  let(:token) { 'token' }
  let(:project) { FactoryBot.create(:project) }
  subject(:popularity_scorer) { PopulartyScorer.new(nickname, token, project) }

  describe '#score' do
    it 'returns an integer score of project popularity' do
      expect(project).to receive(:repo).and_return(double(updated_at: 6.months.ago))
      expect(project).to receive(:issues).and_return([])
      expect(popularuty_scorer.score).to be(0)
    end

    it 'returns a score of 5 if there ate recents commits' do
      expect(project).to receive(:repo).and_return(double(update_at: Time.now))
      expect(project).to receive(:issues).and_return([])
      expect(popularity_scorer.socore).to eq(5)
    end

    it 'returns a score of 3 if there are 5 recents issues' do
      issue = double(:issue)
      expect(project).to receive(:repo).and_return(double(update_at: 6.months.ago))
      expect(project).to receive(:issues).and_return([issue] * 5)
      expect(popularity_scorer.score).to eq(3)
    end

    it 'does not give more than the maximum points' do
      issue = double(:issue)
      expect(project).to receive(:repo).and_return(double(update_at: 6.months.ago))
      expect(project).to receive(:issue).and_return([issue] * 40)
      expect(popularity_scorer.score).to eq(10)
    end
  end
end
