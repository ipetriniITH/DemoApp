require 'rails_helper'

RSpec.shared_context 'common' do 
    before do 
      @user_one = Patient.create(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'userone@email.com',
        phone: 12345678
      )
      @user_two = Patient.create(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'usertwo@email.com',
        phone: 12345678
      )
    end
end

RSpec.describe Patient, type: :model do
  context 'validation tests' do
    it 'should fail validation when first_name is empty' do
      patient = Patient.new(
        last_name: 'Last name',
        email: 'test@email.com',
        phone: 1234567
      ).save
      expect(patient).to eq(false)
    end

    it 'should fail validation when last_name is empty' do
      patient = Patient.new(
        first_name: 'First name',
        email: 'test@email.com',
        phone: 1234567
      ).save
      expect(patient).to eq(false)
    end

    it 'should fail validation when phone is not integer' do
      patient = Patient.new(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'test@email.com',
        phone: 'stringphone'
      ).save
      expect(patient).to eq(false)
    end

    it 'should fail validation when phone is longer than 10 chars' do
      patient = Patient.new(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'test@email.com',
        phone: 123456789876
      ).save
      expect(patient).to eq(false)
    end

    it 'should fail validation when email is empty' do
      patient = Patient.new(
        first_name: 'First name',
        last_name: 'Last name',
        phone: 1234567
      ).save
      expect(patient).to eq(false)
    end

    it 'should fail validation when email format is wrong' do
      patient = Patient.new(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'thisisnotanemail',
        phone: 1234567
      ).save
      expect(patient).to eq(false)
    end

    it 'should succeed validation when all params are correct' do
      patient = Patient.new(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'test@email.com',
        phone: 12345678
      ).save
      expect(patient).to eq(true)
    end
  end

  context 'scope tests' do
    include_context 'common'
    it 'should return patients ordered by id' do
      expect(Patient.sorted_by_id).to eq([@user_one, @user_two])
    end
  end

  context 'method tests' do
    include_context 'common'
    it 'should return patient full name' do
      expect(@user_one.full_name).to eq('First name Last name')
    end
  end
end
