require 'rails_helper'

# Define patient controller action tests.
RSpec.describe "Patients", type: :request do
  # Test index action.
  context 'GET #index' do
    it 'should fail get index when not singed in' do
      get patients_path
      expect(response).not_to be_successful
      expect(flash[:notice]).to eq('Please log in.')
    end

    it 'should succeed get index when singed in' do
      login_as_admin
      get patients_path
      expect(response).to be_successful
    end
  end

  # Test show action.
  context 'GET #show' do
    let(:patient) {
      Patient.create(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'userone@email.com',
        phone: 12345678
      )
    }
    it 'should fail get show when not signed in' do
      get patient_path(patient.id)
      expect(response).not_to be_successful
      expect(flash[:notice]).to eq('Please log in.')
    end

    it 'should succeed get show when signed in' do
      login_as_admin
      get patient_path(patient.id)
      expect(response).to be_successful
    end
  end

  # Test new action.
  context 'GET #new' do
    it 'should fail get new when not singed in' do
      get new_patient_path
      expect(response).not_to be_successful
      expect(flash[:notice]).to eq('Please log in.')
    end

    it 'should succeed get new when singed in' do
      login_as_admin
      get new_patient_path
      expect(response).to be_successful
    end
  end

  # Test create action.
  context 'POST #create' do
    let(:patient_params) {
      {
        first_name: 'First',
        last_name: 'Last',
        email: 'patient@email.com',
        phone: 12345678        
      }
    }

    it 'should fail post create when not singed in' do
      post patients_path, params: { patient: patient_params }
      expect(response).not_to be_successful
      expect(flash[:notice]).to eq('Please log in.')
    end

    it 'should succeed post create when singed in' do
      login_as_admin
      post patients_path, params: { patient: patient_params }
      expect(Patient.last.first_name).to eq(patient_params[:first_name])
      expect(flash[:message]).to eq('Patient \'First Last\' created successfully')
    end
  end

  # Test edit action.
  context 'GET #edit' do
    let(:patient) {
      Patient.create(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'userone@email.com',
        phone: 12345678
      )
    }
    it 'should fail get edit when not signed in' do
      get edit_patient_path(patient.id)
      expect(response).not_to be_successful
      expect(flash[:notice]).to eq('Please log in.')
    end

    it 'should succeed get edit when signed in' do
      login_as_admin
      get edit_patient_path(patient.id)
      expect(response).to be_successful
    end
  end

  # Test update action.
  context 'PATCH #update' do
    let(:patient) {
      Patient.create(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'userone@email.com',
        phone: 12345678
      )
    }
    let(:new_first_name) { 'New first name' }

    it 'should fail patch update when not singed in' do
      patch patient_path(patient.id), params: { patient: { first_name: new_first_name } }
      expect(response).not_to be_successful
      expect(flash[:notice]).to eq('Please log in.')
    end

    it 'should succeed patch update when singed in' do
      login_as_admin
      patch patient_path(patient.id), params: { patient: { first_name: new_first_name } }
      expect(Patient.last.first_name).to eq(new_first_name)
      expect(flash[:message]).to eq('Patient \'New first name Last name\' updated successfully')
    end
  end

  # Test destroy action.
  context 'DELETE #destroy' do
    let(:patient) {
      Patient.create(
        first_name: 'First name',
        last_name: 'Last name',
        email: 'userone@email.com',
        phone: 12345678
      )
    }

    it 'should fail patch destroy when not singed in' do
      delete patient_path(patient.id)
      expect(response).not_to be_successful
      expect(flash[:notice]).to eq('Please log in.')
    end

    it 'should succeed patch destroy when singed in' do
      login_as_admin
      delete patient_path(patient.id)
      expect(Patient.last).to be_nil
      expect(flash[:message]).to eq('Patient \'First name Last name\' destroyed successfully')
    end
  end
end
