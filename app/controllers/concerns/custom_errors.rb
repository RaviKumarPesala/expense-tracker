module CustomErrorChecks
  def role_admin_check
    current_user_role = headers['role'] || 'employee'
    render json: { status: UNAUTHORIZED, message: "User Cannot Perform This Action." } unless current_user_role == 'admin'
  end
end