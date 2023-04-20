require 'rails_helper'

describe CounterHelper, type: :helper do
  context 'with language present' do
    before do
      @language = 'Erlang'
    end

    describe '#peoject_count_for_language' do
      it 'returns the number of project using the given language' do
        3.times { create :project, main_language: @language }
        2.times { create :project, inactive: true, main_language: @language }

        expect(helper.project_coun)
      end
    end
  end
end