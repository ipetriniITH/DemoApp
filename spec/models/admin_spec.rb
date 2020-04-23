require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'validation tests' do
    it 'should fail validation when username is empty' do
      admin = Admin.new(
        email: 'test@email.com',
        password: 'password'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when username length is less than 8' do
      admin = Admin.new(
        username: 'short',
        email: 'test@email.com',
        password: 'password'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when username length is greater than 25' do
      admin = Admin.new(
        username: 'thisisaverylongusernamethatshouldfail',
        email: 'test@email.com',
        password: 'password'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when email is empty' do
      admin = Admin.new(
        username: 'username',
        password: 'password'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when email format is wrong' do
      admin = Admin.new(
        username: 'username',
        email: 'thisisnotanemail',
        password: 'password'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when email confirmation mismatch' do
      admin = Admin.new(
        username: 'username',
        email: 'test@email.com',
        email_confirmation: 'test2@email.com',
        password: 'password'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when password is empty' do
      admin = Admin.new(
        username: 'username',
        email: 'test@email.com',
        email_confirmation: 'test@email.com'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when username is not allowed' do
      admin = Admin.new(
        username: 'fergussuter',
        email: 'test@email.com',
        email_confirmation: 'test@email.com',
        password: 'password'
      ).save
      expect(admin).to eq(false)
    end

    it 'should fail validation when username is not unique' do
      admin1 = Admin.create(
        username: 'username1',
        email: 'test@email.com',
        email_confirmation: 'test@email.com',
        password: 'password'
      )
      admin2 = Admin.new(
        username: 'username1',
        email: 'test@email.com',
        email_confirmation: 'test@email.com',
        password: 'password'
      ).save
      expect(admin2).to eq(false)
    end

    it 'should succeed validation when all params are correct' do
      admin = Admin.new(
        username: 'username',
        email: 'test@email.com',
        email_confirmation: 'test@email.com',
        password: 'password'
      ).save
      expect(admin).to eq(true)
    end
  end
end
