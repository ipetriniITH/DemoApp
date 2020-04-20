class PatientsController < ApplicationController

  def index
    @patients = Patient.sorted_by_id
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    # Defining this method allows to pass default values to the view
    @patient = Patient.new({:email => 'default@email.com'})
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:message] = "Patient '#{@patient.fullName}' created successfully"
      redirect_to(patients_path)
    else
      #If the save fails, the form will be pre-populated with the previous values
      render('new')
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(patient_params)
      flash[:message] = "Patient '#{@patient.fullName}' updated successfully"
      redirect_to(patients_path(@patient))
    else
      #If the save fails, the form will be pre-populated with the previous values
      render('edit')
    end
  end

  def delete
    @patient = Patient.find(params[:id])
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    flash[:message] = "Patient '#{@patient.fullName}' destroyed successfully"
    redirect_to(patients_path)
  end

  private
  def patient_params
    params.require(:patient).permit(:firstName, :lastName, :email, :phone)
  end

end
