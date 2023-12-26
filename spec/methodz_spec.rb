# frozen_string_literal: true

RSpec.describe Methodz do
  before do
    @obj = Object.new
  end

  it 'has a version number' do
    expect(Methodz::VERSION).not_to be nil
  end

  it 'should patch Object class' do
    expect(@obj.methods).to include(:methodz)
  end

  it 'should accept a single, non-parameterized argument' do
    expect(@obj.methodz('var').count).to be < @obj.methodz.count
  end

  it 'should return the same results for either query syntax' do
    expect(@obj.methodz('var')).to eq @obj.methodz(q: 'var')
  end

  it 'should respond with private methods' do
    expect(@obj.private_methods).to include(@obj.methodz(q: 'sys', type: 'private').sample)
  end

  it 'should respond with protected methods' do
    expect(@obj.protected_methods).to eq(@obj.methodz(type: 'protected'))
  end
end
