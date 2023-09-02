require 'rails_helper'

RSpec.describe 'Expense index', type: :feature do
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

  let!(:expense1) do
    Expense.create(
      name: 'expense1',
      amount: 10,
      group_id: group1.id,
      author_id: user1.id
    )
  end

  let!(:expense2) do
    Expense.create(
      name: 'expense2',
      amount: 23,
      group_id: group1.id,
      author_id: user1.id
    )
  end

  before do
    visit new_user_session_path
    fill_in 'Email', with: 'test@mail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'Should show the title of the page' do
    visit user_group_expenses_path(user1, group1)
    expect(page).to have_content('Transactions')
  end

  it 'Should show the name of the group' do
    visit user_group_expenses_path(user1, group1)
    expect(page).to have_content('group1')
  end

  it 'Should show the name of the expenses' do
    visit user_group_expenses_path(user1, group1)
    expect(page).to have_content('expense1')
    expect(page).to have_content('expense2')
  end

  it 'I can remove a expense' do
    visit user_group_expenses_path(user1, group1)
    first('.lnk-delete').click
    expect(page).to_not have_content('expense1')
  end

  it 'I can add a expense' do
    visit user_group_expenses_path(user1, group1)
    click_link 'Add new transaction'
    # on the new page
    fill_in 'expense_name', with: 'expense3'
    fill_in 'expense_amount', with: '25'
    click_button 'Save transaction'
    # return to the index page
    expect(page).to have_content('expense3')
  end
end
