require "application_system_test_case"

class SetlistsTest < ApplicationSystemTestCase
  setup do
    @setlist = setlists(:one)
  end

  test "visiting the index" do
    visit setlists_url
    assert_selector "h1", text: "Setlists"
  end

  test "creating a Setlist" do
    visit setlists_url
    click_on "New Setlist"

    fill_in "Songs", with: @setlist.songs_id
    fill_in "Title", with: @setlist.title
    click_on "Create Setlist"

    assert_text "Setlist was successfully created"
    click_on "Back"
  end

  test "updating a Setlist" do
    visit setlists_url
    click_on "Edit", match: :first

    fill_in "Songs", with: @setlist.songs_id
    fill_in "Title", with: @setlist.title
    click_on "Update Setlist"

    assert_text "Setlist was successfully updated"
    click_on "Back"
  end

  test "destroying a Setlist" do
    visit setlists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Setlist was successfully destroyed"
  end
end
