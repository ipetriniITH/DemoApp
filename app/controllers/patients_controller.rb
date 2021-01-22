# frozen_string_literal: true

# Define the patients controller class.
class PatientsController < ApplicationController
  include AccessHelper

  before_action :confirm_logged_in

  # GET /patients
  # Display patients list.
  def index
    @patients = Patient.sorted_by_id
  end

  # GET /patients/:id
  # Display patient information.
  def show
    @patient = Patient.find(params[:id])
  end

  # GET /patients/new
  # Display patient creation form with default email.
  def new
    @patient = Patient.new(email: 'default@email.com')
  end

  # POST /patients
  # Create a new patient.
  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:message] = "Patient '#{@patient.full_name}' created successfully"
      redirect_to patients_path
    else
      flash[:message] = "Patient couldn't be created"
      render 'new'
    end
  end

  # GET /patients/:id/edit
  # Display patient edition form.
  def edit
    @patient = Patient.find(params[:id])
  end

  # PATCH /patients/:id
  # Update patient information.
  def update
    @patient = Patient.find(params[:id])
    if @patient.update!(patient_params)
      flash[:message] = "Patient '#{@patient.full_name}' updated successfully"
      redirect_to patients_path(@patient)
    else
      render 'edit'
    end
  end

  # GET /patiends/:id/delete
  # Display delete confirmation message.
  def delete
    @patient = Patient.find(params[:id])
  end

  # DELETE /patients/:id
  # Delete patient.
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    flash[:message] = "Patient '#{@patient.full_name}' destroyed successfully"
    redirect_to patients_path
  end

  private

  # Sanitize patient params.
  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :phone)
  end
end
