require 'rails_helper'

RSpec.describe 'Group index', type: :feature do
  let!(:user1) do
    User.create(
      name: 'user1',
      email: 'test@mail.com',
      password: '123456',
      role: 'admin'
    )
  end

  let!(:group1) do
    Group.create(
      name: 'group1',
      icon: 'icon1.png',
      user_id: user1.id
    )
  end

  let!(:group2) do
    Group.create(
      name: 'group2',
      icon: 'icon2.png',
      user_id: user1.id
    )
  end

  before do
    visit new_user_session_path
    fill_in 'Email', with: 'test@mail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'Should show the title of the page' do
    visit user_groups_path(user1)
    expect(page).to have_content('Categories')
  end

  it 'Should show the name of the groups' do
    visit user_groups_path(user1)
    expect(page).to have_content('group1')
    expect(page).to have_content('group2')
  end

  it 'I can remove a group' do
    visit user_groups_path(user1)
    first('.lnk-delete').click
    expect(page).to_not have_content('group1')
  end

  it 'I can add a group' do
    visit user_groups_path(user1)
    click_link 'Add new category'
    # on the new page
    fill_in 'Name', with: 'group3'
    fill_in 'Icon', with: 'something3.png'
    click_button 'Save category'
    # return to the index page
    expect(page).to have_content('group3')
  end
end
