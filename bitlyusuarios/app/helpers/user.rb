helpers do
  # Esto deberá de regresar al usuario con una sesión actual si es que existe 
  def current_user
    @current_user = User.find_by name: "#{session['user']}"
  end

  # Regresa true si el current_user existe y false de otra manera 
  def logged_in?
    if @current_user == nil then false else true
    end
  end
end