require 'rails_helper'

describe 'Admin Projects', type: :request do
  let(:user) { create :user }
  let!(:projects) { %w(apples madarins).map { |repo| create :projects, name: repo, github_url: "http://github.com/christmas/#{repo}" } }
  subject { page }

  before do
    mock_is_admin
    login(user)

    visit admin_projects_path
  end

  describe 'project index' do
    it 'should list all projects' do
      projects.each do |project|
        is_expected.to have_content project.name
      end
    end
  end

  describe 'managing project' do
    it 'search for a project', js: true do
      fill_in 'repository', with: 'apples'
      click_on 'Search'

      sleep(Capybara.default_max_wait_time)

      is_expected.to have_content 'apples'
      is_expected.not_to have_content 'mandarins'
    end

    it 'editing a project', js: true do
      first(:link, 'Edit').trigger('click')

      fill_in 'Name', with: 'Pugalicious'
      click_on 'Update Project'

      is_expected.to have_content 'Project updated successfully!'

      is_expected.to have_content 'Pugalicious'
    end

    it 'deactivates a project' do
      first(:link, 'Deactivate').click

      is_expected.to have_content "#{projects.first.name} has been deactivated."
    end
  end
end
