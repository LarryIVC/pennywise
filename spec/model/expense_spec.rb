require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'jhon@mail.com', password: '123456', role: 'admin') }
  let(:group) { Group.create(name: 'Group 1', icon: 'icon', user_id: user) }
  let(:expense) { Expense.create(name: 'Expense 1', amount: 100, author_id: user.id, group_id: group.id) }

  it 'name should be present' do
    expense.name = nil
    expect(expense).to_not be_valid
  end

  it 'amount should be present' do
    expense.amount = nil
    expect(expense).to_not be_valid
  end

  it 'amount should be greater than 0' do
    expense.amount = 0
    expect(expense).to_not be_valid
  end
end
