class EmployeeRepresenter

  def initialize(employees, role = 'E')
    @employees = employees
  end

  def as_multiple_jsons
    @employees.map do |employee|
      {
        id: employee.id,
        name: employee.name,
        dob: employee.date_of_birth,
        email: employee.email,
        phone: employee.mobile_number,
        address: employee.address,
        pincode: employee.pincode
      }
    end
  end

  def as_single_json
    {
      id: @employees.id,
      name: @employees.name,
      dob: @employees.date_of_birth,
      email: @employees.email,
      phone: @employees.mobile_number,
      address: @employees.address,
      pincode: @employees.pincode
    }
  end

  private
  
  attr_reader :employees

end