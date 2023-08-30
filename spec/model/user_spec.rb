require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', email: 'john@mail.com', password: '123456', role: 'admin') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'email should be present' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'role should be present' do
    subject.role = nil
    expect(subject).to_not be_valid
  end
end
