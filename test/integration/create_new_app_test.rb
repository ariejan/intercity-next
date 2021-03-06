require 'test_helper'

class CreateNewAppTest < IntegrationTest
  test "User should be able to create a new app on a given server" do
    login_as users(:john)
    visit root_path

    server = servers(:example).tap{ |s| s.update(status: "up") }

    within "#server_#{server.id}" do
      click_link "#{server.name}"
    end

    find("a[data-behaviour~='new-app']").click

    fill_in "app[name]", with: "Example app test"

    assert_difference "server.reload.apps.count" do
      click_button "Create app"
    end
  end
end
