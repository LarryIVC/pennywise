require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password', role: 'admin') }
  let(:group) { Group.create(name: 'Group 1', icon: 'icon', user_id: user) }

  it 'name should be present' do
    group.name = nil
    expect(group).to_not be_valid
  end

  it 'icon should be present' do
    group.icon = nil
    expect(group).to_not be_valid
  end
end
