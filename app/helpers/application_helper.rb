module ApplicationHelper
  def omniauth_coposition_path
    path_params = { path: '/auth/coposition_oauth2' }
    URI::HTTP.build(path_params).request_uri
  end
end
